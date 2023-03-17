// ListView.builder(
// physics: const NeverScrollableScrollPhysics(),
// shrinkWrap: true,
// itemCount: cubit.activitiesModel!.result!.length,
// itemBuilder: (context, index) {
// return Padding(
// padding: const EdgeInsets.symmetric(vertical: 8.0),
// child: GestureDetector(
// onTap: (() {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => CategoryDetails(),
// ),
// );
// }),
// child: Container(
// height: 60,
// decoration: BoxDecoration(
// boxShadow: [
// BoxShadow(
// color: Colors.grey.shade300,
// blurRadius: 2.0,
// offset: const Offset(0.0, 4.0),
// ),
// ],
// color: Colors.grey[300],
// ),
// child: Padding(
// padding: const EdgeInsets.all(8.0),
// child: Row(
// children: [
// Container(
// padding: const EdgeInsets.all(10),
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(10),
// ),
// child: const Icon(
// Icons.social_distance,
// color: Colors.black,
// ),
// ),
// const SizedBox(width: 10),
// Expanded(
// child: Center(
// child: Text(
// '${cubit.activitiesModel!.result![index].titleAr}',
// style: const TextStyle(
// // color: Colors.black,
// fontWeight: FontWeight.bold,
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// ),
// );
// },
// ),