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

part of google_maps_places;

class PlaceGeometry extends jsw.TypedJsObject {
  static PlaceGeometry $wrap(js.JsObject jsObject) => jsObject == null ? null : new PlaceGeometry.fromJsObject(jsObject);
  PlaceGeometry.fromJsObject(js.JsObject jsObject)
      : super.fromJsObject(jsObject);
  PlaceGeometry()
      : super();

  set location(LatLng location) => $unsafe['location'] = location == null ? null : location.$unsafe;
  LatLng get location => LatLng.$wrap($unsafe['location']);
  set viewport(LatLngBounds viewport) => $unsafe['viewport'] = viewport == null ? null : viewport.$unsafe;
  LatLngBounds get viewport => LatLngBounds.$wrap($unsafe['viewport']);
}
