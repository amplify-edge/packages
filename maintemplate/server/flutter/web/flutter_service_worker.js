'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/index.html": "e6e557d4e5f3605c0e4eb212827a61f9",
"/main.dart.js": "06dbef9d2d288619485d477153abaa92",
"/lang/de.json": "f893a59ad803624b64a2a3e02d5732b9",
"/lang/zh-cn.json": "40c431f16c06ad1defb9da6192bf89d9",
"/lang/en.json": "01f2ec2c38de3846be15e48be0438b27",
"/lang/fr.json": "32f4db31c5475352b30114b282eae6ab",
"/lang/he.json": "61368c258ee11088cc82114b10814879",
"/lang/es.json": "4ff5caa5a2839013cdc55e25fa5c4015",
"/icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"/icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"/manifest.json": "e6e65afd8c8920598deab424985ce65b",
"/.dart_tool/package_config.json": "f36b8761d37f2612b816596abba1e5ca",
"/assets/LICENSE": "787132fa9b30a66b5e4f13aa1524f363",
"/assets/AssetManifest.json": "27b0b6de6a8f098e7f3bace41e139763",
"/assets/lang/de.json": "f893a59ad803624b64a2a3e02d5732b9",
"/assets/lang/zh-cn.json": "40c431f16c06ad1defb9da6192bf89d9",
"/assets/lang/en.json": "01f2ec2c38de3846be15e48be0438b27",
"/assets/lang/fr.json": "32f4db31c5475352b30114b282eae6ab",
"/assets/lang/he.json": "61368c258ee11088cc82114b10814879",
"/assets/lang/es.json": "4ff5caa5a2839013cdc55e25fa5c4015",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16"
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
