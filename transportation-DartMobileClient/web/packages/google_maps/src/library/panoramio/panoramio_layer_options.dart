// Copyright (c) 2012, Alexandre Ardhuin
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

part of google_maps_panoramio;

class PanoramioLayerOptions extends jsw.TypedProxy {
  static PanoramioLayerOptions cast(js.Proxy proxy) => proxy == null ? null : new PanoramioLayerOptions.fromProxy(proxy);

  PanoramioLayerOptions() : super();
  PanoramioLayerOptions.fromProxy(js.Proxy proxy) : super.fromProxy(proxy);

  bool get clickable => $unsafe['clickable'];
  GMap get map => GMap.cast($unsafe['map']);
  bool get suppressInfoWindows => $unsafe['suppressInfoWindows'];
  String get tag => $unsafe['tag'];
  String get userId => $unsafe['userId'];
  set clickable(bool clickable) => $unsafe['clickable'] = clickable;
  set map(GMap map) => $unsafe['map'] = map;
  set suppressInfoWindows(bool suppressInfoWindows) => $unsafe['suppressInfoWindows'] = suppressInfoWindows;
  set tag(String tag) => $unsafe['tag'] = tag;
  set userId(String userId) => $unsafe['userId'] = userId;
}