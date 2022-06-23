import 'package:flutter/material.dart';

import 'cache_helper.dart';


const baseUrl = 'https://student.valuxapps.com/api/';
const login='login';
const home='home';
const categories='categories';
const Favorites='favorites';
const profile='profile';
const register='register';
const updateProfile='update-profile';
const Search='products/search';


String token=token=CacheHelper.getData(key: 'token');