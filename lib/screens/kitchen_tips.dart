import 'package:flutter/material.dart';
import 'package:receipes/themes/colors.dart';
import 'package:receipes/widgets/widget.dart';

class KitchenTips extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('Kitchen Tips',style: TextStyle(fontFamily: 'Lovely Kids',fontSize: 28.0,letterSpacing: 2.0),),
        backgroundColor: AppColor.denim,
      ),
      body: ListView(
        children: [
          SizedBox(height: 5.0,),
         tipsContainer('1. Eliminate that Tupperware smell by packing them with newspaper.'),
          SizedBox(height: 5.0,),
         tipsCard('images/fruits.jpg', 'Crumpling up newspaper and stacking it into smelly Tupperware overnight is known to  get rid of bad odors. To  wash containers after the fact, as newspapers aren\'t exactly clean.'),
          SizedBox(height:20.0,),
          tipsContainer('2. Prevent bubbling over with a wooden spoon.'),
          SizedBox(height: 5.0,),
          tipsCard('images/woodenspoon.jpg', 'If  pots are boiling over, quickly place a wooden spoon across the rim—that\'ll settle the  bubbles and prevent more over-boiling.'),
          SizedBox(height:20.0,),
          tipsContainer('3. Use rubbing alcohol to clean stainless steel.'),
          SizedBox(height: 5.0,),
          tipsCard('images/steel.jpg', 'Put rubbing alcohol on a few cotton balls and have at it!'),
          SizedBox(height:20.0,),
          tipsContainer('4. Run your potatoes through the dishwasher.'),
          SizedBox(height: 5.0,),
          tipsCard('images/potato.jpg', 'Make sure there\'s no soap in the machine, of course, and a simple rinsing cycle will do the trick.'),
          SizedBox(height:20.0,),
          tipsContainer('5. Heat a dish towel in the microwave to get rid of fish smell.'),
          SizedBox(height: 5.0,),
          tipsCard('images/towel.jpg', 'If you put some dish soap on your dish rag, heat the rag itself for a few minutes, leave the rag in the microwave for about half an hour, return to the rag, and wipe the walls of the microwave down, you will be free of that fishy microwave smell.'),
          SizedBox(height:20.0,),
          tipsContainer('6. File your cookie sheets.'),
          SizedBox(height: 5.0,),
          tipsCard('images/sheet.jpg', 'You can use an actual filing system to hold your baking sheets upright and in an orderly fashion.'),
          SizedBox(height:20.0,),
          tipsContainer('7. Use salt to soak up eggs.'),
          SizedBox(height: 5.0,),
          tipsCard('images/egg.jpg', 'In the off chance you drop a raw egg ,throw some salt on the remnants. It\'ll soak up the egg whites.Magic!'),
          SizedBox(height:20.0,),
          tipsContainer('8. Polish your copper with ketchup.'),
          SizedBox(height: 5.0,),
          tipsCard('images/copper.jpg', 'Dab some ketchup on a cloth and rub it all over your copper. Rinse it in warm water,good as new.'),
          SizedBox(height:20.0,),
          tipsContainer('9. Microwave your sponge'),
          SizedBox(height: 5.0,),
          tipsCard('images/sponge.jpg','For just a few seconds when it\'s gross.'),
          SizedBox(height:20.0,),
          tipsContainer('10. Use cooking spray to make less of a mess'),
          SizedBox(height: 5.0,),
          tipsCard('images/cooking spray.jpg','When measuring out super sticky ingredients, coat your measuring cup with a butter or oil-based cooking spray first. It ensures the sticky substance will slide right out and prevent you from having to scrub at your cups forever afterward.'),
          SizedBox(height:20.0,),
          Text('crd #https://www.delish.com/kitchen-tools/g25654407/best-kitchen-tips/')




        ],
        ),);
  }
}
