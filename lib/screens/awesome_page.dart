import 'package:flutter/material.dart';

class _SliverFixedHeader extends SliverPersistentHeaderDelegate{
  final double maxHeight;
  final double minHeight;
  final Widget child;

  _SliverFixedHeader({
    required this.maxHeight,
    required this.minHeight,
    required this.child
});
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent =>maxHeight;

  @override
  // TODO: implement minExtent
  double get minExtent =>  minHeight;

  @override
  bool shouldRebuild(_SliverFixedHeader oldDelegate) {
    return oldDelegate.maxHeight != maxHeight || oldDelegate.minHeight != minHeight|| oldDelegate.child != child;
  }
  
}

class AwesomePage extends StatefulWidget {
  const AwesomePage({Key? key}) : super(key: key);

  @override
  State<AwesomePage> createState() => _AwesomePageState();
}

class _AwesomePageState extends State<AwesomePage> {

  getColor(index){
    final color = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple
    ];
    return color[index % color.length];
  }

  renderSliverAppBar(){
    return SliverAppBar(
      backgroundColor:Colors.black,
      expandedHeight: 200.0,
      flexibleSpace: Image.asset("assets/images/pusan.jfif",fit: BoxFit.cover,),
      pinned: true,
      floating: true,
      title: Text('Pusan'),
    );
  }

  renderHeader(){
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeader(
        child: Container(
          child: Text('신기하지'),
          decoration: BoxDecoration(
            color: Colors.white,
            border : Border(
              bottom: BorderSide(
                color: Colors.black
              )
            )
          ),
        ),
        minHeight: 75,
        maxHeight: 200,
      ),
    );
  }


  renderSLiverList(){
    return SliverList(delegate: SliverChildBuilderDelegate((context, index){
      return Container(
        color: getColor(index),
        height: 100.0,
      );
    },),);
  }

  renderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          return Container(
            color: getColor(
              index,
            ),
          );
        },
        childCount: 32,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        renderSliverAppBar(),
        renderHeader(),
        renderSliverGrid(),
        renderHeader(),
        renderSliverGrid(),
        renderHeader(),
        renderSliverGrid(),

      ],
    );
  }
}
