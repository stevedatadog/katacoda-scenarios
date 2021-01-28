import requests
import random
import time

from random_word import RandomWords

from flask import Flask, Response, jsonify
from flask import request as flask_request

from sqlalchemy.orm import joinedload

from bootstrap import create_app
from models import Discount, db

r = RandomWords()

app = create_app()
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

@app.route('/')
def hello():
    return Response({'Hello from Discounts!': 'world'}, mimetype='application/json')

@app.route('/discount', methods=['GET'])
def get_discount():
    discounts = Discount.query.options(joinedload('*')).all()
    app.logger.info(f"Discounts available: {len(discounts)}")

    influencer_count = 0
    for discount in discounts:
        if discount.discount_type.influencer:
            influencer_count += 1
    app.logger.info(f"Total of {influencer_count} influencer specific discounts as of this request")
    return jsonify([b.serialize() for b in discounts])

@app.route('/discount', methods=['POST'])
def add_discount():
    # create a new discount with random name and value
    discounts_count = len(Discount.query.all())
    new_discount = Discount('Discount ' + str(discounts_count + 1), 
                            r.get_random_word(),
                            random.randint(10,500))
    app.logger.info(f"Adding discount {new_discount}")
    db.session.add(new_discount)
    db.session.commit()
    new_id = new_discount.id
    app.logger.info("New discount added with id %d", new_discount.id)

    return jsonify({"id": new_id})

@app.route('/discount<id>', methods=['DELETE'])
def delete_discount(id):
    # delete a record with the given id

    app.logger.info("Deleting discount with id %d", id)
    Discount.query.filter(Discount.id == id).delete()
    db.session.commit()
    app.logger.info("Discount id %d deleted", id)

    return jsonify({"id": id})