import 'package:domain/model/favourite.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_details_arguments.freezed.dart';

@freezed
abstract class FavouriteDetailsArguments with _$FavouriteDetailsArguments {
  factory FavouriteDetailsArguments({
    required Favourite favourite,
    VoidCallback? onSuccessDelete,
    VoidCallback? onSuccessEdit,
  }) = _FavouriteDetailsArguments;
}
