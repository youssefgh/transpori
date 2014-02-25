// Copyright (c) 2013, Alexandre Ardhuin
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

part of js_wrapping;

typedef T Mapper<F, T>(F o);

/// convert dart object to the js side. It's a little like `new JsObject.jsify(data)` but with unwrapping of [Serializable]s and it support all types.
dynamic jsify(data) {
  // shortcut for simple case to avoid instantiation of _convertedObjects
  if (data is Serializable) {
    return data.$unsafe;
  } else if (isTransferable(data)) {
    return data;
  } else if (data is JsObject) {
    return data;
  } else if (data is! List && data is! Map) {
    return data;
  }

  // handle json-like structures
  final _convertedObjects = new HashMap.identity();
  _convert(o) {
    if (_convertedObjects.containsKey(o)) {
      return _convertedObjects[o];
    }
    if (o is Serializable) {
      return o.$unsafe;
    } else if (isTransferable(o)) {
      return o;
    } else if (o is JsObject) {
      return o;
    } else if (o is Map) {
      final convertedMap = new JsObject(context['Object']);
      _convertedObjects[o] = convertedMap;
      for (var key in o.keys) {
        convertedMap[key] = _convert(o[key]);
      }
      return convertedMap;
    } else if (o is Iterable) {
      var convertedList = new JsArray();
      _convertedObjects[o] = convertedList;
      convertedList.addAll(o.map(_convert));
      return convertedList;
    } else {
      return o;
    }
  }
  return _convert(data);
}

bool isTransferable(data) => data == null ||
    data is num || data is bool || data is String || data is DateTime ||
    data is Blob || data is Event || data is ImageData || data is Node || data is Window ||
    data is KeyRange ||
    data is TypedData;

/// Calls [Serializable.$unwrap] if [o] is a [Serializable].
mayUnwrap(o) => o is Serializable ? Serializable.$unwrap(o) : o;

typedef _EventSinkCallback<T>(EventSink<T> eventSink);

/// Utility class to create streams from event retrieve with subscribe/unsubscribe
class SubscribeStreamProvider<T> implements EventSink<T> {
  final _EventSinkCallback<T> subscribe;
  final _EventSinkCallback<T> unsubscribe;
  final _controllers = new List<StreamController<T>>();

  SubscribeStreamProvider({subscribe(EventSink<T> eventSink), unsubscribe(EventSink<T> eventSink)})
      : subscribe = subscribe,
        unsubscribe = unsubscribe;

  void _addController(StreamController<T> controller) {
    _controllers.add(controller);
    if (_controllers.length == 1 && subscribe != null) subscribe(this);
  }

  void _removeController(StreamController<T> controller) {
    _controllers.remove(controller);
    if (_controllers.isEmpty && unsubscribe != null) unsubscribe(this);
  }

  Stream<T> get stream {
    StreamController<T> controller;
    controller = new StreamController<T>(
        onListen: () => _addController(controller),
        onCancel: () => _removeController(controller),
        sync: true);
    return controller.stream;
  }

  void add(T event) => _controllers.toList().forEach((controller) => controller.add(event));
  void addError(errorEvent, [StackTrace stackTrace]) => _controllers.toList().forEach((controller) => controller.addError(errorEvent, stackTrace));
  void close() => _controllers.toList().forEach((controller) => controller.close());
}