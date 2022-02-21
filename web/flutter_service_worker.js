'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/assets/simulations/EpicycloidDark.png": "a1006098a040c78c59cae9a7fa96aaf6",
"assets/assets/simulations/InsertionSortDark.png": "46227946b3b7d87cb38c6b3205b20f5e",
"assets/assets/simulations/Epicycloid1Dark.png": "d69869e8f0a1cc3e871e7ebb16173655",
"assets/assets/simulations/ToothpickPatternDark.png": "3171fd88c38962336c24cc6ca27207d9",
"assets/assets/simulations/FourierSeriesLight.png": "ea8aa43a41ba783ea24ca100654e8dba",
"assets/assets/simulations/RosePatternDark.png": "545a511f6228795db69c917303b4a685",
"assets/assets/simulations/MaurerRoseDark.png": "6319224310a535e31ddb70ae8c05dc25",
"assets/assets/simulations/LissajousCurveLight.png": "22417f10aa006f85be0663c00a08a903",
"assets/assets/simulations/MaurerRoseLight.png": "b8a1169f80a42b6c7feaa389b2130345",
"assets/assets/simulations/FourierSeriesDark.png": "fcbc72e1190ddddef1f8f8a47adb35d9",
"assets/assets/simulations/BubbleSortDark.png": "4b85f2c087e39c517bdc104df334eaae",
"assets/assets/simulations/InsertionSortLight.png": "93c2287045fcb47d1434748a8264392f",
"assets/assets/simulations/RosePatternLight.png": "3d02b0057f145e4f9307c6dff510521e",
"assets/assets/simulations/Epicycloid.png": "84d9a376ec1c7b3c0c0a69bdbeba7b1b",
"assets/assets/simulations/ToothpickPatternLight.png": "2a91cb57480962637463a3674dc6af94",
"assets/assets/simulations/LissajousCurveDark.png": "a18a1f3b7f99ae24919b2ce30aa5447f",
"assets/assets/simulations/BubbleSortLight.png": "261c56778d34cb57023e3556e3caf86e",
"assets/assets/simulations/Epicycloid1Light.png": "7f566a19db5026b0aed628104a8e74b7",
"assets/assets/images/builtree.svg": "31f8533d6828e91789b49da8a2100f2f",
"assets/android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png": "423773f7ed9beb6161d3ee3fd6447bb1",
"assets/FontManifest.json": "dd2f2ccfd341cc28c6f1ca3e7c357837",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/AssetManifest.json": "cf9c5d9cce5479498a911cf47bd0a484",
"assets/NOTICES": "be60bd971b7dc63b75b1b7ee4cf9966a",
"assets/fonts/Ubuntu-Regular.ttf": "238c32cd050af8099eeaa8f50dd04ec9",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"index.html": "a24590cb68b9ced6cd13a44ea0b1c7a2",
"/": "a24590cb68b9ced6cd13a44ea0b1c7a2",
"version.json": "f91490e18e79302bd6fb3992c63bd532",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"main.dart.js": "88a5c55ddd6325546e0540ea3ef29a1d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"manifest.json": "a2b0ace2b69a7f377a6fc400508411ff",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
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
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
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
