/**
 * after web-platform-tests/html/dom/elements/global-attributes/dataset-get.html
 * @assertion 
 * @description Dataset - Get
 */
import 'dart:html';
import "../../../../Utils/expectWeb.dart";

void main() {
      void testGet(attr, expected) {
        var d = document.createElement("div");
        d.setAttribute(attr, "value");
        return d.dataset[expected] == "value";
      }

      test(() { assert_true(testGet('data-foo', 'foo')); },
        "Getting element.dataset['foo'] should return the value of element.getAttribute('data-foo')'");
      test(() { assert_true(testGet('data-foo-bar', 'fooBar')); },
        "Getting element.dataset['fooBar'] should return the value of element.getAttribute('data-foo-bar')'");
      test(() { assert_true(testGet('data--', '-')); },
        "Getting element.dataset['-'] should return the value of element.getAttribute('data--')'");
      test(() { assert_true(testGet('data--foo', 'Foo')); },
        "Getting element.dataset['Foo'] should return the value of element.getAttribute('data--foo')'");
      test(() { assert_true(testGet('data---foo', '-Foo')); },
        "Getting element.dataset['-Foo'] should return the value of element.getAttribute('data---foo')'");
      test(() { assert_true(testGet('data-Foo', 'foo')); },
        "Getting element.dataset['foo'] should return the value of element.getAttribute('data-Foo')'");
      test(() { assert_true(testGet('data-', '')); },
        "Getting element.dataset[''] should return the value of element.getAttribute('data-')'");
      test(() { assert_true(testGet('data-\xE0', '\xE0')); },
        "Getting element.dataset['\xE0'] should return the value of element.getAttribute('data-\xE0')'");
      test(() { assert_true(testGet('data-to-string', 'toString')); },
        "Getting element.dataset['toString'] should return the value of element.getAttribute('data-to-string')'");

      void matchesNothingInDataset(attr)
      {
        var d = document.createElement("div");
        d.setAttribute(attr, "value");

        if (!d.dataset)
          return false;

        var count = 0;
        for (var item in d.dataset)
          count++;
        return count == 0;
      }

      test(() { assert_true(matchesNothingInDataset('dataFoo')); },
        "Tests that an attribute named dataFoo does not make an entry in the dataset DOMStringMap.");

      checkTestFailures();
}