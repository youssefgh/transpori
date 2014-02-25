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

class ScaleControlStyle extends jsw.IsEnum<String> {
  static final _FINDER = new jsw.EnumFinder<String, ScaleControlStyle>([DEFAULT]);
  static ScaleControlStyle $wrap(String jsValue) => _FINDER.find(jsValue);

  static final DEFAULT = new ScaleControlStyle._(maps['ScaleControlStyle']['DEFAULT']);

  ScaleControlStyle._(String value)
      : super(value);
}
