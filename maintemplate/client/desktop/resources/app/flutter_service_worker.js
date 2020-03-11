'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/manifest.json": "e76912b2c927d8ceaf0adc19179b1902",
"/icons/Icon-192.png": "176a86534259068744556ebb5588a8c4",
"/icons/Icon-512.png": "176a86534259068744556ebb5588a8c4",
"/main.dart.js.deps": "f455090f65ca8e46bbc5fa2d6a8f0199",
"/lang/en.json": "01f2ec2c38de3846be15e48be0438b27",
"/lang/es.json": "4ff5caa5a2839013cdc55e25fa5c4015",
"/lang/de.json": "f893a59ad803624b64a2a3e02d5732b9",
"/lang/he.json": "61368c258ee11088cc82114b10814879",
"/lang/zh-cn.json": "40c431f16c06ad1defb9da6192bf89d9",
"/lang/fr.json": "32f4db31c5475352b30114b282eae6ab",
"/main.dart.js": "1e694f810003f5dc6c79a85889b64bae",
"/index.html": "5100c224702445270a2b63a1a0a7637e",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/AssetManifest.json": "037c6c7a8db65872e4e533fe5e1ddd41",
"/assets/FontManifest.json": "cc1a521ccfd5705915ca1af9c6fee5b7",
"/assets/lang/en.json": "01f2ec2c38de3846be15e48be0438b27",
"/assets/lang/es.json": "4ff5caa5a2839013cdc55e25fa5c4015",
"/assets/lang/de.json": "f893a59ad803624b64a2a3e02d5732b9",
"/assets/lang/he.json": "61368c258ee11088cc82114b10814879",
"/assets/lang/zh-cn.json": "40c431f16c06ad1defb9da6192bf89d9",
"/assets/lang/fr.json": "32f4db31c5475352b30114b282eae6ab",
"/assets/LICENSE": "3c7b5bfd948fb7e698cc74a0b6b2850d",
"/assets/packages/rflutter_alert/assets/images/icon_success.png": "8bb472ce3c765f567aa3f28915c1a8f4",
"/assets/packages/rflutter_alert/assets/images/3.0x/icon_success.png": "1c04416085cc343b99d1544a723c7e62",
"/assets/packages/rflutter_alert/assets/images/3.0x/close.png": "98d2de9ca72dc92b1c9a2835a7464a8c",
"/assets/packages/rflutter_alert/assets/images/3.0x/icon_error.png": "15ca57e31f94cadd75d8e2b2098239bd",
"/assets/packages/rflutter_alert/assets/images/3.0x/icon_info.png": "e68e8527c1eb78949351a6582469fe55",
"/assets/packages/rflutter_alert/assets/images/3.0x/icon_warning.png": "e5f369189faa13e7586459afbe4ffab9",
"/assets/packages/rflutter_alert/assets/images/2.0x/icon_success.png": "7d6abdd1b85e78df76b2837996749a43",
"/assets/packages/rflutter_alert/assets/images/2.0x/close.png": "abaa692ee4fa94f76ad099a7a437bd4f",
"/assets/packages/rflutter_alert/assets/images/2.0x/icon_error.png": "2da9704815c606109493d8af19999a65",
"/assets/packages/rflutter_alert/assets/images/2.0x/icon_info.png": "612ea65413e042e3df408a8548cefe71",
"/assets/packages/rflutter_alert/assets/images/2.0x/icon_warning.png": "e4606e6910d7c48132912eb818e3a55f",
"/assets/packages/rflutter_alert/assets/images/close.png": "13c168d8841fcaba94ee91e8adc3617f",
"/assets/packages/rflutter_alert/assets/images/icon_error.png": "f2b71a724964b51ac26239413e73f787",
"/assets/packages/rflutter_alert/assets/images/icon_info.png": "3f71f68cae4d420cecbf996f37b0763c",
"/assets/packages/rflutter_alert/assets/images/icon_warning.png": "ccfc1396d29de3ac730da38a8ab20098",
"/assets/packages/modtemplate02/lang/en.json": "01f2ec2c38de3846be15e48be0438b27",
"/assets/packages/modtemplate02/lang/es.json": "4ff5caa5a2839013cdc55e25fa5c4015",
"/assets/packages/modtemplate02/lang/de.json": "f893a59ad803624b64a2a3e02d5732b9",
"/assets/packages/modtemplate02/lang/he.json": "61368c258ee11088cc82114b10814879",
"/assets/packages/modtemplate02/lang/zh-cn.json": "40c431f16c06ad1defb9da6192bf89d9",
"/assets/packages/modtemplate02/lang/fr.json": "32f4db31c5475352b30114b282eae6ab",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "d51b09f7b8345b41dd3b2201f653c62b",
"/assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "51d23d1c30deda6f34673e0d5600fd38",
"/assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "0ea892e09437fcaa050b2b15c53173b7",
"/assets/packages/mod_write/assets/pipeline.png": "8c9fc40f75bf7f3177c7fdfe42d2c88f",
"/assets/packages/mod_write/assets/hambach.png": "a0296a60c6be105203fa68f78cd0649d",
"/assets/packages/mod_write/assets/london_strike.png": "876b63d116f0a231e812486706097969",
"/assets/packages/mod_geo/assets/marker.jpg": "b08a21be9bfdff85bf8e3d14bec9bcd8",
"/assets/assets/pipeline.png": "8c9fc40f75bf7f3177c7fdfe42d2c88f",
"/assets/assets/hambach.png": "a0296a60c6be105203fa68f78cd0649d",
"/assets/assets/london_strike.png": "876b63d116f0a231e812486706097969",
"/assets/assets/env.json": "186c8d250927b33f657292917c26c4e9"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
