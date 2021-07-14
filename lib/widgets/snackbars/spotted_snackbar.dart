import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spotted/application/dimen.dart';

enum SpottedSnackbarType {
  info,
  success,
  error,
  warning,
}

abstract class SpottedSnackbar {
  static Future<void> show(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 2),
  }) async {
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => _SpottedSnackbar(
        toastDuration: duration,
        overlayEntry: entry,
        title: title,
        message: message,
      ),
    );

    Overlay.of(context)?.insert(entry);
  }

  static Future<void> showError(
    BuildContext context, {
    required String message,
    String? title,
    Duration duration = const Duration(seconds: 5),
  }) async {
    OverlayEntry? entry;
    entry = OverlayEntry(
      builder: (context) => _SpottedSnackbar(
        toastDuration: duration,
        overlayEntry: entry,
        title: title,
        message: message,
        type: SpottedSnackbarType.error,
      ),
    );

    Overlay.of(context)?.insert(entry);
  }
}

class _SpottedSnackbar extends StatefulWidget {
  const _SpottedSnackbar({
    Key? key,
    this.overlayEntry,
    required this.message,
    this.toastDuration = const Duration(seconds: 2),
    this.type = SpottedSnackbarType.info,
    this.title,
  }) : super(key: key);

  final OverlayEntry? overlayEntry;
  final Duration toastDuration;
  final SpottedSnackbarType type;
  final String? title;
  final String message;

  @override
  State<StatefulWidget> createState() => _SpottedSnackbarState();
}

class _SpottedSnackbarState extends State<_SpottedSnackbar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  static const double _contentMargin = 20;
  static const double _leftContainerRadius = 8;
  static const double _leftContainerWidth = 5;
  static const double _snackbarRadius = 12;
  static const double _snackbarElevation = 8;
  static const double _snackbarSymmetricPadding = 0;
  static const double _snackbarBottomPadding = 20;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    )..addListener(() {
        if (_controller.isDismissed) {
          widget.overlayEntry?.remove();
        }
      });

    Timer(widget.toastDuration, () {
      _controller.reverse();
    });

    _controller.forward();
  }

  Color get _snakbarAccentColor {
    switch (widget.type) {
      case SpottedSnackbarType.info:
        return const Color(0xff668AFF);
      case SpottedSnackbarType.success:
        return const Color(0xff1BD2A4);
      case SpottedSnackbarType.error:
        return const Color(0xffF42829);
      case SpottedSnackbarType.warning:
        return const Color(0xffFF6E01);
    }
  }

  String get _contextEmoji {
    switch (widget.type) {
      case SpottedSnackbarType.info:
        return 'ℹ️';
      case SpottedSnackbarType.success:
        return '🙌';
      case SpottedSnackbarType.error:
        return '';
      case SpottedSnackbarType.warning:
        return '⚠️';
    }
  }

  String get _title {
    if (widget.title == null) {
      switch (widget.type) {
        case SpottedSnackbarType.info:
          return 'Did you known?';
        case SpottedSnackbarType.success:
          return 'Congrats!';
        case SpottedSnackbarType.error:
          return 'Something went wrong!';
        case SpottedSnackbarType.warning:
          return 'Warning';
      }
    } else {
      return widget.title!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom + _snackbarBottomPadding,
      left: _snackbarSymmetricPadding,
      right: _snackbarSymmetricPadding,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Insets.medium),
        child: Center(
          child: Material(
            elevation: _snackbarElevation,
            borderRadius: BorderRadius.circular(_snackbarRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: Insets.large),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: _leftContainerWidth,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: _snakbarAccentColor,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(_leftContainerRadius),
                        ),
                      ),
                    ),
                    const SizedBox(width: _contentMargin),
                    if (_contextEmoji.isNotEmpty) ...[
                      Text(
                        _contextEmoji,
                        style: Theme.of(context).textTheme.caption,
                      ),
                      const SizedBox(width: _contentMargin),
                    ],
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _title,
                            style: Theme.of(context).textTheme.caption?.copyWith(color: _snakbarAccentColor),
                          ),
                          Text(
                            widget.message,
                            style: GoogleFonts.nunitoSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: const Color(0xff8E8C94),
                              height: 16 / 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
