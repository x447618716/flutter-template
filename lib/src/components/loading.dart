import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/theme.dart';

enum LoadingType {
  textButton,
}

class Loading extends StatefulWidget {
  const Loading({
    super.key,
    required this.child,
    required this.future,
    this.type = LoadingType.textButton,
    this.backgroundColor,
    this.padding,
    this.expanded = true,
    this.progressColor,
    this.shape,
    this.minSize = Size.zero,
  });

  final Widget child;
  final AsyncCallback future;
  final LoadingType type;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final bool expanded;
  final Color? progressColor;
  final OutlinedBorder? shape;
  final Size? minSize;

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = false;
  bool _isDisposed = false;

  Widget _empty() => const SizedBox.shrink();

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Widget _textButton() => TextButton(
        onPressed: _isLoading
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                FocusScope.of(context).unfocus();
                await widget.future();
                if (!_isDisposed) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
        style: TextButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? context.primaryColor,
          padding: widget.padding ?? EdgeInsets.all(15.r),
          minimumSize: widget.minSize,
          shape: widget.shape,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isLoading)
              SizedBox(
                width: 15.r,
                height: 15.r,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: widget.progressColor ?? context.onPrimaryColor,
                ),
              ),
            if (_isLoading) SizedBox(width: 5.w),
            widget.child,
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    switch (widget.type) {
      case LoadingType.textButton:
        if (widget.expanded) {
          return Row(
            children: [
              Expanded(
                child: _textButton(),
              ),
            ],
          );
        }
        return _textButton();
      default:
        return _empty();
    }
  }
}
