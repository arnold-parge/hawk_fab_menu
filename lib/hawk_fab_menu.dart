library hawk_fab_menu;

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

/// Wrapper that builds a FAB menu on top of [body] in a [Stack]
class HawkFabMenu extends StatefulWidget {
  final Widget body;
  final List<HawkFabMenuItem> items;
  final double blur;
  final Color shadowColor;
  final AnimatedIconData icon;
  final Color fabColor;
  final Color iconColor;
  HawkFabMenu({
    this.body,
    @required this.items,
    this.blur: 5.0,
    this.shadowColor: Colors.black12,
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
  /// To check if the menu is open
  bool _isOpen = false;

  /// The [Duration] for every animation
  Duration _duration = Duration(milliseconds: 500);

  /// Animation controller that animates the menu item
  AnimationController _iconAnimationCtrl;

  /// Animation that animates the menu item
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

  /// Closes the menu if open and vice versa
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

  /// If the menu is open and the device's back button is pressed then menu gets closed instead of going back.
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

  /// Returns animated list of menu items
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

  /// Builds the blur effect when the menu is opened
  Widget _buildBlurWidget() {
    return InkWell(
      onTap: _toggleMenu,
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: this.widget.blur,
          sigmaY: this.widget.blur,
        ),
        child: Container(
          color: widget.shadowColor,
        ),
      ),
    );
  }

  /// Builds the main floating action button of the menu to the bottom right
  /// On clicking of which the menu toggles
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

/// Builds widget for a single menu item
class _MenuItemWidget extends StatelessWidget {
  /// Contains details for a single menu item
  final HawkFabMenuItem item;

  /// A callback that toggles the menu
  final Function toggleMenu;

  _MenuItemWidget({
    @required this.item,
    @required this.toggleMenu,
  });

  /// Closes the menu and calls the function for a particular menu item
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
              style: TextStyle(color: this.item.labelColor ?? Colors.black87),
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

/// Model for single menu item
class HawkFabMenuItem {
  /// Text label for for the menu item
  String label;

  /// Corresponding icon for the menu item
  Icon icon;

  /// Action that is to be performed on tapping the menu item
  Function ontap;

  /// Background color for icon
  Color color;

  /// Text color for label
  Color labelColor;

  /// Background color for label
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
