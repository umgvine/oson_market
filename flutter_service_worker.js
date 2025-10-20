'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter.js": "888483df48293866f9f41d3d9274a779",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"manifest.json": "0a82adf65f3d2c443ca3a86e4e6fe64e",
"index.html": "92ad4809605e8eab267cb83775d5022e",
"/": "92ad4809605e8eab267cb83775d5022e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "8d0cb6f64c5f8449a2b5ac2d85330f14",
"assets/assets/categories/odejda.png": "08f27d877ac8a210462e52a766660270",
"assets/assets/categories/detskiya_tovary.png": "06626abac1423e72099abb6687aeb05b",
"assets/assets/categories/stroitelstvo_i_remont.png": "d1f4d0ed208c26a877e4ff467e41bd56",
"assets/assets/categories/bytovaya_tehnika.png": "34af8033e2bb821bab3d4be91ec87579",
"assets/assets/categories/krasota.png": "739404182cae9e94a0716edf3efa3805",
"assets/assets/categories/sport.png": "6e0175a10e26124da11585b4e90dc34e",
"assets/assets/categories/apteka.png": "1ef4420824dc0e9e903a5da1bebde20b",
"assets/assets/categories/elektronika.png": "724adf8ab68b85c09c7e4c5c8835f41d",
"assets/assets/categories/dlya_jivotnyh.png": "6f6118532796c6716e4d4bf35a76f393",
"assets/assets/categories/knigi.png": "c9d0dba18b7d6022a22f3655d263227b",
"assets/assets/categories/mebel.png": "b19c290bba0060d5e5ea8687f191f613",
"assets/assets/categories/dom_i_sad.png": "a8dc6e5a92707c7e990bbcb9a8a9c0ce",
"assets/assets/subcategories/women.png": "6075bafb536e2ea0cc2008b84e7c4f07",
"assets/assets/subcategories/laptops.png": "b69300deca5e10f3b15612d120f7dae1",
"assets/assets/subcategories/men.png": "7dddffea9cfca529316d0569ad4b9788",
"assets/assets/subcategories/phones.png": "9f7a7dda6c87697489fce4b701f6dfeb",
"assets/assets/subcategories/tv.png": "f5e80acdfe57db5c3b9c2bbf4cabc7ee",
"assets/assets/subcategories/kids.png": "5442858ffb762c076c6bed1ba568c6f7",
"assets/assets/fonts/Montserrat-SemiBold.ttf": "c1bd726715a688ead84c2dbf4c82f88d",
"assets/assets/fonts/Montserrat-Regular.ttf": "07689d4eaaa3d530d58826b5d7f84735",
"assets/assets/fonts/Montserrat-Bold.ttf": "d3085f686df272f9e1a267cc69b2d24f",
"assets/assets/fonts/Gagalin-Regular.otf": "9affe4eb2249bc2d26f88debe5eb0d31",
"assets/assets/fonts/Montserrat-Medium.ttf": "9d496514aedf5c9bb3f689de8b094cd8",
"assets/assets/banners/summer_sale_banner.png": "34d3bb5b2701d7f706481f45d269aa44",
"assets/assets/banners/watches_banner.png": "d10040589f6e12465b986562e491e3ba",
"assets/assets/banners/shoes_banner.png": "80eaa4ada5d176e20fd833f7ef5c9289",
"assets/assets/app_icon_anim.png": "592569ee0496ead59e24af16594d05c3",
"assets/assets/demo/demo_product.png": "3b51d9e296fe4fcd25597a0e3418bd31",
"assets/fonts/MaterialIcons-Regular.otf": "02c480ad1fc33bf9ce6b765b59d9adc0",
"assets/NOTICES": "811fa50e4d8cd0103b81142ccf4c4676",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/FontManifest.json": "947882e2f914501b16d377b5d23f530d",
"assets/AssetManifest.bin": "531b8c863f10284380d5c2ee95d82231",
"assets/AssetManifest.json": "185634d785b0594bf6933c46a08f9ec0",
"canvaskit/chromium/canvaskit.wasm": "24c77e750a7fa6d474198905249ff506",
"canvaskit/chromium/canvaskit.js": "5e27aae346eee469027c80af0751d53d",
"canvaskit/chromium/canvaskit.js.symbols": "193deaca1a1424049326d4a91ad1d88d",
"canvaskit/skwasm_heavy.wasm": "8034ad26ba2485dab2fd49bdd786837b",
"canvaskit/skwasm_heavy.js.symbols": "3c01ec03b5de6d62c34e17014d1decd3",
"canvaskit/skwasm.js": "1ef3ea3a0fec4569e5d531da25f34095",
"canvaskit/canvaskit.wasm": "07b9f5853202304d3b0749d9306573cc",
"canvaskit/skwasm_heavy.js": "413f5b2b2d9345f37de148e2544f584f",
"canvaskit/canvaskit.js": "140ccb7d34d0a55065fbd422b843add6",
"canvaskit/skwasm.wasm": "264db41426307cfc7fa44b95a7772109",
"canvaskit/canvaskit.js.symbols": "58832fbed59e00d2190aa295c4d70360",
"canvaskit/skwasm.js.symbols": "0088242d10d7e7d6d2649d1fe1bda7c1",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter_bootstrap.js": "19b5e013fab527e0ef1eea3263f773fe",
"version.json": "3d8e80d2418bb6a7a97adbbb1261f917",
"main.dart.js": "00695bf98f1e55845ac27229f0a71e47"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
