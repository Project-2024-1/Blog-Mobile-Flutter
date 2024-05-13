import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tudotaichinh/model/ListPostModel.dart';

import '../../../common/setting_view.dart';


class WidgetPostList extends StatefulWidget {
  final ListPostModel postItem;
  const WidgetPostList({Key? key,required this.postItem}) : super(key: key);

  @override
  State<WidgetPostList> createState() => _WidgetPostListState();
}

class _WidgetPostListState extends State<WidgetPostList> {
  var imgVariable;

  @override
  Widget build(BuildContext context) {
    String urlImage = '${widget.postItem.postImage}';
    
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: CachedNetworkImage(
                    height: MediaQuery.of(context).size.height *.3/2 + height20(context),
                    width: MediaQuery.of(context).size.height *.2 + height10(context),
                    imageUrl: urlImage,
                    placeholder: (context, url) => LinearProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.blueGrey.shade50,
                    ),
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Image(image: AssetImage('assets/img/error.png',), fit: BoxFit.cover,)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                color: Colors.black.withOpacity(0.5),
                margin:const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Text(
                  '${widget.postItem.postTitle}',
                  maxLines: 3, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5,),
        Text('${widget.postItem.postDescription}', maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),),
      ],
    );
  }
}
