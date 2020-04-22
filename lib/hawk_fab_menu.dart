library hawk_fab_menu;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AtomFabMenu extends StatefulWidget {
  final Widget body;
  final List<AtomFabMenuItem> items;
  final double blur;
  AtomFabMenu({
    @required this.body,
    @required this.items,
    this.blur: 0.8,
  }) {
    assert(this.items.length > 0);
  }

  @override
  _AtomFabMenuState createState() => _AtomFabMenuState();
}

class _AtomFabMenuState extends State<AtomFabMenu>
    with TickerProviderStateMixin {
  bool _isOpen = false;
  Duration _duration = Duration(milliseconds: 500);
  AnimationController _iconAnimationCtrl;
  Animation<double> _iconAnimationTween;

  @override
  void initState() {
    super.initState();
    _iconAnimationCtrl = AnimationController(
      vsync: this,
      duration: _duration,
    );
    _iconAnimationTween = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(_iconAnimationCtrl);
  }

  void _toggleOpen() {
    setState(() {
      _isOpen = !_isOpen;
    });
    if (_isOpen) {
      _iconAnimationCtrl.forward();
    } else {
      _iconAnimationCtrl.reverse();
    }
  }

  Future<bool> _preventPopIfOpen() async {
    if (_isOpen) {
      _toggleOpen();
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Stack(
        children: <Widget>[
          widget.body,
          if (_isOpen) _buildBlurWidget(),
          if (_isOpen) _buildMenuItemList(),
          _buildMenuButton(context),
        ],
      ),
      onWillPop: _preventPopIfOpen,
    );
  }

  Widget _buildMenuItemList() {
    return Positioned(
      bottom: 80,
      right: 15,
      child: ScaleTransition(
        scale: AnimationController(
          vsync: this,
          value: 0.7,
          duration: _duration,
        )..forward(),
        child: SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: AnimationController(
            vsync: this,
            value: 0.5,
            duration: _duration,
          )..forward(),
          child: FadeTransition(
            opacity: AnimationController(
              vsync: this,
              value: 0.0,
              duration: _duration,
            )..forward(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: this
                  .widget
                  .items
                  .map<Widget>((item) => _buildMenuItem(item))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(AtomFabMenuItem item) {
    var onTap = () {
      _toggleOpen();
      item.ontap();
    };
    return InkWell(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(item.label),
          ),
          FloatingActionButton(
            onPressed: onTap,
            mini: true,
            child: item.icon,
          ),
        ],
      ),
    );
  }

  Widget _buildBlurWidget() {
    return InkWell(
      onTap: _toggleOpen,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: this.widget.blur,
          sigmaY: this.widget.blur,
        ),
        child: Container(
          color: Colors.black12,
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context) {
    return Positioned(
      bottom: 10,
      right: 10,
      child: FloatingActionButton(
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _iconAnimationTween,
        ),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: _toggleOpen,
      ),
    );
  }
}

class AtomFabMenuItem {
  String label;
  Icon icon;
  Function ontap;
  AtomFabMenuItem({
    @required this.label,
    @required this.ontap,
    @required this.icon,
  });
}
