import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_template/src/components/empty.dart';
import 'package:flutter_template/src/localization/localization_extension.dart';
import 'package:flutter_template/src/theme.dart';

class RefreshController<T> {
  RefreshController(this._refreshCallback, this._updateData);

  final Future<void> Function() _refreshCallback;
  final void Function(List<T>) _updateData;

  Future<void> refresh() async {
    await _refreshCallback();
  }

  void updateData(List<T> data) {
    _updateData(data);
  }
}

class RefreshBuilder<T> extends StatefulWidget {
  const RefreshBuilder({
    super.key,
    this.future,
    required this.builder,
    this.refreshController,
    this.limit = 20,
    this.separatorBuilder,
    this.loadMore = true,
    this.backgroundColor,
    this.listViewForce = false,
  });

  final Future<List<T>?> Function(int offset, int limit)? future;
  final Widget Function(BuildContext context, T data) builder;
  final void Function(RefreshController<T> controller)? refreshController;
  final Widget Function(BuildContext, int)? separatorBuilder;
  final bool loadMore;
  final bool listViewForce;
  final int limit;
  final Color? backgroundColor;

  @override
  State<RefreshBuilder<T>> createState() => _RefreshBuilderState<T>();
}

class _RefreshBuilderState<T> extends State<RefreshBuilder<T>> {
  late AsyncSnapshot<List<T>?> _snapshot;
  late RefreshController<T> _refreshController;
  late ScrollController _scrollController;
  late bool _notAnyMore;
  late bool _loadingMore;
  Object? _activeCallbackIdentity;

  @override
  void initState() {
    super.initState();
    _notAnyMore = false;
    _loadingMore = false;
    _refreshController = RefreshController<T>(_refresh, _updateData);
    if (widget.loadMore) {
      _scrollController = ScrollController()
        ..addListener(() {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            _loadMore();
          }
        });
    }
    if (widget.refreshController != null) {
      widget.refreshController!(_refreshController);
    }
    _snapshot = AsyncSnapshot<List<T>>.nothing();
    _init();
  }

  Widget _buildMore() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              _notAnyMore
                  ? context.localization.notAnyMore
                  : context.localization.loading,
              style: context.bodySmall,
            ),
            if (!_notAnyMore) SizedBox(width: 5.r),
            if (!_notAnyMore)
              SizedBox(
                width: 20.r,
                height: 20.r,
                child: const CircularProgressIndicator(
                  strokeWidth: 1.0,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == _snapshot.data!.length) {
      return _buildMore();
    }
    return widget.builder(context, _snapshot.data![index]);
  }

  Widget _separatorBuilder(BuildContext context, int index) {
    if (widget.separatorBuilder != null) {
      return widget.separatorBuilder!(context, index);
    }
    return const SizedBox.shrink();
  }

  Widget _buildChild() {
    if (_snapshot.connectionState == ConnectionState.done &&
        _snapshot.hasData &&
        _snapshot.data!.isNotEmpty) {
      if (widget.loadMore || widget.listViewForce) {
        return ListView.separated(
          padding: EdgeInsets.all(20.r),
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: _itemBuilder,
          separatorBuilder: _separatorBuilder,
          itemCount: _snapshot.data!.length + 1,
          controller: _scrollController,
        );
      } else {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                for (var i = 0; i < _snapshot.data!.length; i++)
                  widget.builder(context, _snapshot.data![i]),
              ],
            ),
          ),
        );
      }
    }
    return Empty(
      loading: _snapshot.connectionState != ConnectionState.done,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: _buildChild(),
    );
  }

  @override
  void dispose() {
    _retset();
    super.dispose();
  }

  void _updateData(List<T> data) {
    setState(() {
      _snapshot = AsyncSnapshot<List<T>>.withData(ConnectionState.done, data);
    });
  }

  void _setData(List<T>? data, {bool notAnyMore = false}) {
    setState(() {
      _loadingMore = false;
      _notAnyMore = data == null ||
          data.isEmpty ||
          data.length < widget.limit ||
          notAnyMore;
      _snapshot = AsyncSnapshot<List<T>?>.withData(ConnectionState.done, data);
    });
    _retset();
  }

  void _setError(Object error, StackTrace stackTrace) {
    setState(() {
      _snapshot = AsyncSnapshot<List<T>>.withError(
          ConnectionState.done, error, stackTrace);
    });
    _retset();
  }

  Future<void> _refresh() async {
    if (widget.future == null || _activeCallbackIdentity != null) {
      return;
    }
    final Object callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;
    await widget.future!(0, widget.limit).then<void>((List<T>? data) {
      if (_activeCallbackIdentity == callbackIdentity) {
        _setData(data);
      }
    }, onError: (Object error, StackTrace stackTrace) {
      if (_activeCallbackIdentity == callbackIdentity) {
        _setError(error, stackTrace);
      }
    });
  }

  void _loadMore() async {
    if (widget.future == null || _activeCallbackIdentity != null) {
      return;
    }
    if (_loadingMore || _notAnyMore) {
      return;
    }
    setState(() {
      _loadingMore = true;
    });
    final offset = _snapshot.data?.length ?? 0;
    final Object callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;
    widget.future!(offset, widget.limit).then<void>((List<T>? data) {
      if (_activeCallbackIdentity == callbackIdentity) {
        final List<T> list = _snapshot.data ?? [];
        if (data != null) {
          list.addAll(data);
        }
        _setData(
          list,
          notAnyMore:
              data == null || data.isEmpty || data.length < widget.limit,
        );
      }
    }, onError: (Object error, StackTrace stackTrace) {
      if (_activeCallbackIdentity == callbackIdentity) {
        _setError(error, stackTrace);
      }
    });
  }

  void _init() {
    if (widget.future == null) {
      return;
    }
    final Object callbackIdentity = Object();
    _activeCallbackIdentity = callbackIdentity;
    widget.future!(0, widget.limit).then<void>((List<T>? data) {
      if (_activeCallbackIdentity == callbackIdentity) {
        _setData(data);
      }
    }, onError: (Object error, StackTrace stackTrace) {
      if (_activeCallbackIdentity == callbackIdentity) {
        _setError(error, stackTrace);
      }
    });

    if (_snapshot.connectionState != ConnectionState.done) {
      _snapshot = _snapshot.inState(ConnectionState.waiting);
    }
  }

  void _retset() {
    _activeCallbackIdentity = null;
  }
}
