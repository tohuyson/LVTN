import 'package:fooddelivery/model/address.dart';
import 'package:fooddelivery/model/categories.dart';
import 'package:fooddelivery/model/food.dart';
import 'package:fooddelivery/model/function_profile.dart';
import 'package:fooddelivery/model/images.dart';
import 'package:fooddelivery/model/order.dart';
import 'package:fooddelivery/model/restaurants.dart';
import 'package:fooddelivery/model/sizes.dart';
import 'package:fooddelivery/model/slide_banner.dart';
import 'package:fooddelivery/model/toppings.dart';
import 'package:fooddelivery/model/users.dart';
import 'package:fooddelivery/screens/order/order_delivery.dart';
import 'package:fooddelivery/screens/restaurant/restaurant_screen.dart';

Address address_1 = new Address(
  id: 1,
  addressDetail: 'Tòa Cẩm Tú',
  address:
      'Đường số 9 , đại học nông lâm, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam',
  long: 10.873504,
  lat: 106.791406,
);
Address address_2 = new Address(
  id: 1,
  addressDetail: 'Tòa Cẩm Tú',
  address:
      'Đường số 9 , đại học nông lâm, Thủ Đức, Thành phố Hồ Chí Minh, Việt Nam',
  long: 10.873504,
  lat: 106.791406,
);

List<Address> listAddress = [
  address_1,
  address_2,
];

List<FunctionProfile> listFunction = [
  FunctionProfile(name: 'Thanh toán', widget: RestaurantsScreen()),
  FunctionProfile(name: 'Địa chỉ', widget: null),
  FunctionProfile(name: 'Người giao hàng', widget: OrderDelivery()),
  FunctionProfile(name: 'Đơn hàng của tôi', widget: null),
  FunctionProfile(name: 'Trung tâm hỗ trợ', widget: null),
  FunctionProfile(name: 'Chính sách và quy định', widget: null),
  FunctionProfile(name: 'Cài đặt', widget: null),
];

Users users = new Users(
  id: 1,
  name: "Huy Sơn",
  phone: '0986937275',
  token: '',
  listAddress: listAddress,
  listFunction: listFunction,
);

Images image_1 = new Images(
    id: 1,
    url: 'https://dulichbmt.com/wp-content/uploads/2020/04/draynuur.jpg');
Images image_2 = new Images(
    id: 2,
    url:
        'https://hotelthanhmai.com/wp-content/uploads/2020/03/huong-dan-duong-den-thac-dray-nur-2.jpg');

List<Images> listImage = [image_1, image_2];
Restaurants restaurant = new Restaurants(
  id: 1,
  name: 'Cơm Chiên Linh Đông',
  listImage: listImage,
  address: 'Kiot số 1, DH Nông Lâm, Linh Trung, Thủ Đức, Hồ Chí Minh',
  long: 10.868637,
  lat: 106.787603,
  listFood: listFood,
);

Food food_1 = new Food(
  id: 1,
  name: 'Cơm Thịt Luộc',
  image:
      'https://phunuvietnam.mediacdn.vn/179072216278405120/2020/12/2/base64-16068949492551901667229.png',
  price: 20000,
  restaurantId: 1,
  listTopping: null,
  size: null,
);
Food food_2 = new Food(
  id: 2,
  name: 'Cơm Sườn',
  image:
      'https://thumb.connect360.vn/unsafe/600x0/imgs.emdep.vn%2fShare%2fImage%2f2021%2f01%2f14%2fsinh-1-155304839.jpg',
  price: 20000,
  restaurantId: 1,
);
Food food_3 = new Food(
  id: 3,
  name: 'Cơm Cá Chiên',
  image: 'https://kenh14cdn.com/2019/12/26/photo-1-15773581477301587406297.jpg',
  price: 20000,
  restaurantId: 1,
);
Food food_4 = new Food(
  id: 4,
  name: 'Trà sữa trân châu đường đen',
  image:
      'https://photographer.com.vn/wp-content/uploads/2020/09/1601227486_Bo-anh-Girl-xinh-hoc-sinh-cap-3-dep-nhuc.jpg',
  listTopping: listTopping,
  restaurantId: 1,
  size: size_2,
  price: 20000,
);

List<Food> listFood = [
  food_1,
  food_2,
  food_3,
  food_4,
  food_1,
  food_2,
  food_3,
  food_4,
  food_1,
  food_2,
  food_3,
  food_4
];

List<Topping> listTopping = [
  topping_1,
  topping_2,
];
Map<int, Food> listFoodOrder = {4: food_4, 2: food_1};

//Home
List<SlideBanner> banners = [
  SlideBanner(
      url:
          'https://images.foody.vn/delivery/collection/s320x200/image-58937a8c-210511003253.jpeg'),
  SlideBanner(
      url:
          'https://images.foody.vn/delivery/collection/s320x200/image-29242f79-210519152743.jpeg'),
  SlideBanner(
      url:
          'https://images.foody.vn/delivery/collection/s320x200/image-3c72a92f-210507112418.jpeg')
];
List<Category> categorys = [
  Category(name: 'Cơm', url: 'healthy-eating.png'),
  Category(name: 'Phở', url: 'ramen.png'),
  Category(name: 'Hủ Tiếu', url: 'noodles.png'),
  Category(name: 'Bánh Canh', url: 'noodles_c.png'),
  Category(name: 'Nước Mía', url: 'ice-coffee.png'),
  Category(name: 'Coffee', url: 'hot-cup.png'),
  Category(name: 'Trà Sữa', url: 'iced-tea.png'),
  Category(name: 'Voucher', url: 'voucher.png'),
  Category(name: 'Quán yêu thích', url: 'like.png'),
  Category(name: 'Giao Hàng', url: 'delivery-man.png'),
];

// order
Order order_1 = new Order(
  id: 1,
  user: users,
  restaurant: restaurant,
  price: 100000,
  method: 'Thanh Toán tiền mặt',
  category: 'Đồ ăn',
  listFood: listFoodOrder,
  status: false,
);
Order order_2 = new Order(
  id: 2,
  user: users,
  restaurant: restaurant,
  price: 100000,
  method: 'Thanh Toán tiền mặt',
  category: 'Đồ ăn',
  listFood: listFoodOrder,
  status: true,
);
Order order_3 = new Order(
  id: 3,
  user: users,
  restaurant: restaurant,
  price: 100000,
  method: 'Thanh Toán tiền mặt',
  category: 'Đồ ăn',
  listFood: listFoodOrder,
  status: true,
);
List<Order> listOrder = [order_1, order_2, order_3];

Topping topping_1 = new Topping(
  id: 1,
  name: 'Chân trâu trằng',
  price: 5000,
);
Topping topping_2 = new Topping(
  id: 2,
  name: 'Thạch củ năng',
  price: 5000,
);
Topping topping_3 = new Topping(
  id: 3,
  name: 'Chân trâu đen',
  price: 5000,
);
Size size_1 = new Size(
  id: 1,
  name: "S",
  price: 0,
);
Size size_2 = new Size(
  id: 1,
  name: "M",
  price: 5000,
);
Size size_3 = new Size(
  id: 1,
  name: "L",
  price: 10000,
);
