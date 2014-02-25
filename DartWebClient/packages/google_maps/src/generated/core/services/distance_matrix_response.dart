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

part of google_maps;

class DistanceMatrixResponse extends jsw.TypedJsObject {
  static DistanceMatrixResponse $wrap(js.JsObject jsObject) => jsObject == null ? null : new DistanceMatrixResponse.fromJsObject(jsObject);
  DistanceMatrixResponse.fromJsObject(js.JsObject jsObject)
      : super.fromJsObject(jsObject);
  DistanceMatrixResponse();

  set destinationAddresses(List<String> destinationAddresses) => $unsafe['destinationAddresses'] = jsw.jsify(destinationAddresses);
  List<String> get destinationAddresses => jsw.TypedJsArray.$wrap($unsafe['destinationAddresses']);
  set originAddresses(List<String> originAddresses) => $unsafe['originAddresses'] = jsw.jsify(originAddresses);
  List<String> get originAddresses => jsw.TypedJsArray.$wrap($unsafe['originAddresses']);
  set rows(List<DistanceMatrixResponseRow> rows) => $unsafe['rows'] = jsw.jsify(rows);
  List<DistanceMatrixResponseRow> get rows => jsw.TypedJsArray.$wrapSerializables($unsafe['rows'], DistanceMatrixResponseRow.$wrap);
}
