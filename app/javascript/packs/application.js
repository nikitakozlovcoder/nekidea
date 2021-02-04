// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import '../styles/application.scss'

import {Router} from "../general/router.js"

let router = new Router();

document.addEventListener("turbolinks:load", function() {    
   router.callWhen((entry)=>{
       require('pages/home.js').start();
       //Log js-file object
       console.log(require('pages/home.js'));
    }, "home/index",  "home/about")

    router.callWhen((entry)=>{
        require('pages/login.js').start();
    }, "users/login")
    
  
});
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
