/*
 * QR.Flutter
 * Copyright (c) 2019 the QR.Flutter authors.
 * See LICENSE for distribution and usage details.
 */

import 'package:flutter/widgets.dart';

/// Represents a specific element / part of a QR code. This is used to isolate
/// the different parts so that we can style and modify specific parts
/// independently.
enum QrCodeElement {
  /// The 'stroke' / outer square of the QR code finder pattern element.
  finderPatternOuter,

  /// The inner/in-between square of the QR code finder pattern element.
  finderPatternInner,

  /// The "dot" square of the QR code finder pattern element.
  finderPatternDot,

  /// The individual pixels of the QR code
  codePixel,

  /// The "empty" pixels of the QR code
  codePixelEmpty,
}

/// Enumeration representing the three finder pattern (square 'eye') locations.
enum FinderPatternPosition {
  /// The top left position.
  topLeft,

  /// The top right position.
  topRight,

  /// The bottom left position.
  bottomLeft,
}

/// for determining dot / inner of eye
enum QrEyeDot {
  /// square eye dot
  square,

  /// circle eye dot
  dot
}

/// Determining data module type
enum QrDataModuleShape {
  /// normal square
  square,

  /// rounded with fixed radius
  rounded,

  /// extra rounded with fixed radius
  extraRounded,

  /// circle
  dots,

  /// top left, bottom right radius
  classy,

  /// top left, bottom right radius more rounded
  classyRounded
}

/// Enumeration representing the finder pattern eye's shape.
enum QrEyeOuter {
  /// square outer
  square,

  /// rounded outer
  rounded,

  /// circle outer
  circle,
}

/// Enumeration representing the shape of Data modules inside QR.
enum QrEyeModuleShape {
  /// Use square dots.
  square,

  /// Use circular dots.
  circle,
}

/// Enumeration representing the shape behind embedded picture
enum EmbeddedImageShape {
  /// Disable
  none,

  /// Use square.
  square,

  /// Use circular.
  circle,
}

/// Styling options for finder pattern eye.
@immutable
class QrEyeStyle {
  /// Create a new set of styling options for QR Eye.
  const QrEyeStyle({
    this.eyeOuter = QrEyeOuter.square,
    this.eyeDot = QrEyeDot.square,
    this.color,
  });

  /// Eye outer.
  final QrEyeOuter eyeOuter;

  /// Eye dot.
  final QrEyeDot eyeDot;

  /// Color to tint the eye.
  final Color? color;

  /// Border radius figma max value 120 / current max 24
  /// value / 120 * 24 = setting value
  final double borderRadius = 13.5;

  @override
  int get hashCode => eyeOuter.hashCode ^ eyeDot.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is QrEyeStyle) {
      return eyeOuter == eyeOuter &&
          eyeDot == other.eyeDot &&
          color == other.color;
    }
    return false;
  }
}

/// Styling options for data module.
@immutable
class QrDataModuleStyle {
  /// Create a new set of styling options for data modules.
  const QrDataModuleStyle({
    this.dataModuleShape = QrDataModuleShape.square,
    this.color,
    this.roundedOutsideCorners = false,
    double? outsideBorderRadius,
  }) : _outsideBorderRadius = outsideBorderRadius;

  /// Data module shape.
  final QrDataModuleShape dataModuleShape;

  /// Color to tint the data modules.
  final Color? color;

  /// Only [QrDataModuleShape.square]
  /// true for rounded outside corners
  final bool roundedOutsideCorners;

  /// Only [QrDataModuleShape.square]
  /// Border radius for outside corners
  final double? _outsideBorderRadius;

  /// for getting static borderRadius
  double get borderRadius {
    switch (dataModuleShape) {
      case QrDataModuleShape.rounded:
      case QrDataModuleShape.classy:
        return 5.5;
      case QrDataModuleShape.classyRounded:
      case QrDataModuleShape.extraRounded:
        return 10;
      default:
        return 0;
    }
  }

  /// check whether the module shape is classy or not
  bool get isClassy {
    return dataModuleShape == QrDataModuleShape.classyRounded ||
        dataModuleShape == QrDataModuleShape.classy;
  }

  /// if [roundedOutsideCorners] == true, then by default use [borderRadius]
  /// [_outsideBorderRadius] <= [borderRadius]
  /// Get border radius for outside corners
  double get outsideBorderRadius {
    if (roundedOutsideCorners) {
      return _outsideBorderRadius != null &&
              _outsideBorderRadius! < borderRadius
          ? _outsideBorderRadius!
          : borderRadius;
    }
    return 0;
  }

  @override
  int get hashCode => dataModuleShape.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is QrDataModuleStyle) {
      return dataModuleShape == other.dataModuleShape && color == other.color;
    }
    return false;
  }
}

/// Styling options for any embedded image overlay
@immutable
class QrEmbeddedImageStyle {
  /// Create a new set of styling options.
  const QrEmbeddedImageStyle({
    this.size,
    this.color,
    this.safeArea = false,
    this.safeAreaMultiplier = 1,
    this.embeddedImageShape = EmbeddedImageShape.none,
    this.shapeColor,
    this.borderRadius = 0,
  });

  /// The size of the image. If one dimension is zero then the other dimension
  /// will be used to scale the zero dimension based on the original image
  /// size.
  final Size? size;

  /// Color to tint the image.
  final Color? color;

  /// Hide data modules behind embedded image.
  /// Data modules are not displayed inside area
  final bool safeArea;

  /// Safe area size multiplier.
  final double safeAreaMultiplier;

  /// Shape background embedded image
  final EmbeddedImageShape embeddedImageShape;

  /// Border radius shape
  final double borderRadius;

  /// Color background
  final Color? shapeColor;

  /// Check to see if the style object has a non-null, non-zero size.
  bool get hasDefinedSize => size != null && size!.longestSide > 0;

  @override
  int get hashCode => size.hashCode ^ color.hashCode;

  @override
  bool operator ==(Object other) {
    if (other is QrEmbeddedImageStyle) {
      return size == other.size && color == other.color;
    }
    return false;
  }
}
