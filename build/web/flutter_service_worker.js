'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "ba910ad429ea6bd49b345ca2f13da2c9",
"index.html": "7720c683b7d13eefe9b872e31c68c29e",
"/": "7720c683b7d13eefe9b872e31c68c29e",
"main.dart.js": "9670db8c7eb42f7501b9bb9219e6c6b4",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "ea65cd561b98f10b6b41a35239d4a633",
"assets/AssetManifest.json": "8538336b845b39e67860290f4bdeb30f",
"assets/NOTICES": "74668f118c2836514da07c9531dec055",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "de9548ec80eae8bd9c5d88e519176b9e",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/panara_dialogs/assets/info.png": "e4bb5858c90ab48c72f11ba44bb26b5b",
"assets/packages/panara_dialogs/assets/confirm.png": "acf806139cb7c12e09fc5ca1185b8a2f",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "e75aee944c785dad58506e2e4ca85af7",
"assets/fonts/MaterialIcons-Regular.otf": "2e7c43d101041a8897d690054a4a74f7",
"assets/assets/images/shop-and-hospital.tsj": "50907a036c7170fc5d34ff03e55ee856",
"assets/assets/images/shop-and-hospital.png": "8a3c6ac84f4942e9f67005f4bb43167e",
"assets/assets/images/Npcs/nurse2_idle.png": "8c7691bc61d06b833470b1265bb2deae",
"assets/assets/images/Npcs/nurse3_idle.png": "430fae09bb54dcb9692a007afcbedd6c",
"assets/assets/images/Npcs/manager_idle.png": "29ddbba0f67749053431918e7efb4bf4",
"assets/assets/images/Npcs/nurse1_idle.png": "f90ff374794af0ff5e00e8f964545842",
"assets/assets/images/Npcs/receptionist_idle.png": "47f5d9dfe28378a601265599040b3b49",
"assets/assets/images/hospital.tmj": "68b20d536246a0561052bf1f16296521",
"assets/assets/images/nurse.tsj": "fe773fdea33b3140cdb8c7eef2886f05",
"assets/assets/images/human.png": "7e5d257d818a12a74dab746c59498440",
"assets/assets/images/Documents/shop-and-hospital.tsj": "60852e81b686c44f27b080865c7e74eb",
"assets/assets/images/Documents/shop-and-hospital.png": "8a3c6ac84f4942e9f67005f4bb43167e",
"assets/assets/images/Documents/hospital.tmj": "1108282f446729e6a44408467217cdeb",
"assets/assets/images/Items/ivermectina.jpg": "5b62d7daf6cebacd93f191e02c5330fd",
"assets/assets/images/Items/ivermectina.png": "e8cacbfd1dc6203d52e64dc9d93d64d8",
"assets/assets/images/Items/cloroquina.png": "e74a79d4151853ecec973cc4b62a1862",
"assets/assets/images/Avatars/pazuello.jpg": "e584c05771ae5a226a4a5a7e4319c6ac",
"assets/assets/images/Avatars/queiroga.jpg": "a1ed8ed72dbc238cc21f6bc9bf216aaa",
"assets/assets/images/Avatars/michelle.jpg": "ed0e2274a52a3f5314ef6c09ebe5b565",
"assets/assets/images/Avatars/nise.webp": "8052c7d0c8ff390a59f4cd4db76ae5cb",
"assets/assets/images/Avatars/damares.jpg": "4cda6bc09b290ee2b0466490953b359c",
"assets/assets/images/Avatars/gu.jpeg": "2d02fe09688f22f988ed05ea1760daa3",
"assets/assets/images/emote_exclamacao.png": "8b1897ae92f3a077e0aadaef2626d65a",
"assets/assets/audio/bg.mp3": "29ac55777546e8a95c04ac04de817bbf",
"assets/assets/audio/catched.mp3": "caa73550a08713d5cca44ad8ef71a25d",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
