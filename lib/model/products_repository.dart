// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'product.dart';

class ProductsRepository {
  static List<Product> loadProducts(Category category) {
    const allProducts = <Product>[
      Product(
        category: Category.accessories,
        id: 0,
        star: 5,
        name: 'Handong Hotel 1',
        address: 'Seoul',
        phone: '010-1111-1111',
        des: 'this is Handong Hotel 1'
      ),
      Product(
        category: Category.accessories,
        id: 1,
        star: 2,
        name: 'Handong Hotel 2',
        address: 'Seoul2',
        phone: '010-2222-2222',
          des: 'this is Handong Hotel 2'
      ),
      Product(
        category: Category.accessories,
        id: 2,
        star: 3,
        name: 'Handong Hotel 3',
        phone: '010-3333-3333',
        address: 'Seoul3',
          des: 'this is Handong Hotel 3'
      ),
      Product(
        category: Category.accessories,
        id: 3,
        star: 4,
        name: 'Handong Hotel 4',
        phone: '010-4444-4444',
        address: 'Seoul4',
          des: 'this is Handong Hotel 4'
      ),
      Product(
        category: Category.accessories,
        id: 4,
        star: 3,
        name: 'Handong Hotel 5',
        phone: '010-5555-5555',
        address: 'Seoul5',
          des: 'this is Handong Hotel 5'
      ),
      Product(
        category: Category.accessories,
        id: 5,
        star: 1,
        name: 'Handong Hotel 6',
        phone: '010-6666-6666',
        address: 'Seoul6',
          des: 'this is Handong Hotel 6'
      ),
    ];
    if (category == Category.all) {
      return allProducts;
    } else {
      return allProducts.where((Product p) {
        return p.category == category;
      }).toList();
    }
  }
}
