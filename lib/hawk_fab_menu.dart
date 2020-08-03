library hawk_fab_menu;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class HawkFabMenu extends StatefulWidget {
  final Widget body;
  final List<HawkFabMenuItem> items;
  final double blur;
  final AnimatedIconData icon;
  final Color fabColor;
  final Color iconColor;
  HawkFabMenu({
    @required this.body,
    @required this.items,
    this.blur: 5.0,
    this.icon,
    this.fabColor,
    this.iconColor,
  }) {
    assert(this.items.length > 0);
  }

  @override
  _HawkFabMenuState createState() => _HawkFabMenuState();
}

class _HawkFabMenuState extends State<HawkFabMenu>
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

  void _toggleMenu() {
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
      _toggleMenu();
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
          _isOpen ? _buildBlurWidget() : Container(),
          _isOpen ? _buildMenuItemList() : Container(),
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
                  .map<Widget>(
                    (item) => _MenuItemWidget(
                      item: item,
                      toggleMenu: _toggleMenu,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlurWidget() {
    return InkWell(
      onTap: _toggleMenu,
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
          icon: this.widget.icon ?? AnimatedIcons.menu_close,
          progress: _iconAnimationTween,
          color: this.widget.iconColor,
        ),
        backgroundColor: this.widget.fabColor ?? Theme.of(context).primaryColor,
        onPressed: _toggleMenu,
      ),
    );
  }
}

class _MenuItemWidget extends StatelessWidget {
  final HawkFabMenuItem item;
  final Function toggleMenu;

  _MenuItemWidget({
    @required this.item,
    @required this.toggleMenu,
  });

  void onTap() {
    this.toggleMenu();
    this.item.ontap();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: this.onTap,
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 3,
            ),
            decoration: BoxDecoration(
              color: this.item.labelBackgroundColor ?? Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
            child: Text(
              this.item.label,
              style: TextStyle(
                color: this.item.labelColor ?? Colors.black87
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: this.onTap,
            mini: true,
            child: this.item.icon,
            backgroundColor: this.item.color ?? Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

class HawkFabMenuItem {
  String label;
  Icon icon;
  Function ontap;
  Color color;
  Color labelColor;
  Color labelBackgroundColor;
  HawkFabMenuItem({
    @required this.label,
    @required this.ontap,
    @required this.icon,
    this.color,
    this.labelBackgroundColor,
    this.labelColor,
  });
}
