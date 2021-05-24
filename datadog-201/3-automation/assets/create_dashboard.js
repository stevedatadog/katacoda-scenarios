#!/usr/bin/env node
const {promises: {readFile}} = require('fs')
const dogapi = require("dogapi");

const clientOptions = {
  api_key: process.env.DD_API_KEY,
  app_key: process.env.DD_APP_KEY,
};
dogapi.initialize(clientOptions);

const dashOptions = {}

readFile("dashboard.json").then(fileBuffer => {
    const dashTemplate = fileBuffer.toJSON();
    console.log(dashTemplate); // debug
    dashOptions.templateVariables = dashTemplate.template_variables;
    dashOptions.readOnly = dashTemplate.is_read_only;
    const dashTitle = "New Dashboard from Node";
    const dashWidgets = dashTemplate.widgets
        dogapi.screenboard.create(
          dashTitle, dashWidgets, dashOptions,
          function(err, res){
            console.dir(res);
          }
        );
}).catch(error => {
  console.error(error.message);
  process.exit(1);
});

