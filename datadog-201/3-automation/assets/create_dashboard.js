#!/usr/bin/env node
const {promises: {readFile}} = require('fs')
const dogapi = require("dogapi");

const clientOptions = {
  api_key: process.env.DD_API_KEY,
  app_key: process.env.DD_APP_KEY,
};
dogapi.initialize(clientOptions);

const dashOptions = {}

// @todo create the redis cpu system monitor and pass it in to the dashboard

readFile("dashboard.json").then(fileBuffer => {
    const dashTemplate = JSON.parse(fileBuffer);
    console.log(dashTemplate.widgets); // debug
    dashOptions.templateVariables = dashTemplate.template_variables;
    dashOptions.readOnly = dashTemplate.is_read_only;
    dashOptions.description = dashTemplate.description;
    const dashTitle = "New Dashboard from Node";
    console.log(dashOptions); // debug
    dogapi.screenboard.create(
      dashTitle, dashWidgets, dashOptions, function(err, res){
        console.dir(res);
      }
    );
}).catch(error => {
  console.error(error.message);
  process.exit(1);
});