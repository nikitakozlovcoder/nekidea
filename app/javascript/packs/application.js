// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import 'bootstrap'
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start();
require("channels")
import '../vendor/jquery.nice-select.min.js'
import 'owl.carousel/dist/assets/owl.carousel.css';
import 'owl.carousel/dist/assets/owl.theme.default.css';
import 'owl.carousel';

import '../styles/application.scss'

import {Router} from "../general/router.js"

let router = new Router();

document.addEventListener("turbolinks:load", function() {

    
    router.callAlways ((entry) => {
        //alert('hi!');
        $(document).ready(function() {
            $('select').niceSelect();
        });

        require('general/carousel.js').start();
        require('general/textarea_scroll.js').start();
    })


    router.callWhen((entry)=>{

       require('pages/home.js').start();
       //Log js-file object
       console.log(require('pages/home.js'));
    }, "home/index",  "home/about")

    router.callWhen((entry)=>{
        require('pages/login.js').start();
    }, "users/login")

    router.callWhen((entry)=>{
        require('pages/vote_create.js').start();
    }, "test/vote_create", "votes/new", "votes/edit", "votes/update", "votes/create")

    router.callWhen((entry)=>{

        require('pages/vote.js').start();
    }, "votes/show", "test/idea");


    
  
});
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
