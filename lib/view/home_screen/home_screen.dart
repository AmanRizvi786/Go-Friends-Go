import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/chat_models/fetch_messages_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:gofriendsgo/services/chats/fetch_messages_service.dart';
import 'package:gofriendsgo/services/shared_preferences.dart';
import 'package:gofriendsgo/utils/constants/mediaquery.dart';
import 'package:gofriendsgo/utils/constants/paths.dart';
import 'package:gofriendsgo/utils/constants/screen_padding.dart';
import 'package:gofriendsgo/utils/constants/sizedbox.dart';
import 'package:gofriendsgo/utils/navigations/navigations.dart';
import 'package:gofriendsgo/view/cab_rates_screen/cab_rates_screen.dart';
import 'package:gofriendsgo/view_model/banner_viewmodel.dart';
import 'package:gofriendsgo/view_model/bookings_viewmodel.dart';
import 'package:gofriendsgo/view_model/carosual_viewmodel.dart';
import 'package:gofriendsgo/view_model/chats/chat_list_viewmodel.dart';
import 'package:gofriendsgo/view_model/departure_viewmodel.dart';
import 'package:gofriendsgo/view_model/gallery_viewmodel.dart';
import 'package:gofriendsgo/view_model/profile_viewmodel.dart';
import 'package:gofriendsgo/view_model/sales_exe_viewmodel.dart';
import 'package:gofriendsgo/view_model/service_viewmodel.dart';
import 'package:gofriendsgo/view_model/stories_viewmodel.dart';
import 'package:gofriendsgo/view_model/team_viewmodel.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/carosual_widget.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/category_widgets.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/drawer_widget.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/grid_for_home.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/home_appbar.dart';
import 'package:gofriendsgo/widgets/home_screen_widgets/story_widget.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    func(context);
    super.initState();
  }

  PageController adController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawerWidget(),
      backgroundColor: const Color.fromARGB(255, 232, 243, 248),
      appBar: PreferredSize(
          preferredSize: Size(double.infinity, mediaqueryheight(0.08, context)),
          child: const HomeAppbar()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: commonScreenPadding(context)),
            const StoryViewWidget(),
            HomeCarosualWidget(adController: adController),
            const CustomSizedBoxHeight(0.01),
            Consumer<CarosualViewModel>(
              builder: (context, carosualViewModel, child) {
                if (carosualViewModel.isLoading) {
                  return CircularProgressIndicator();
                }
                // Get the total count of carousel items
                final carouselCount = carosualViewModel.carouselsModel?.data.length ?? 0;
                return Transform.scale(
                  scale: 0.5,
                  child: SmoothPageIndicator(
                    controller: adController,
                    count: carouselCount, // Set the count dynamically
                  ),
                );
              },
            ),
            const GridForHomeScreen(),
            const CategoriesWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
              child: Container(
                height: mediaqueryheight(0.12, context),
                width: mediaquerywidth(1, context),
                
                child: GestureDetector(
                  onTap: () => PageNavigations().push(const CabRatesScreen()),
                  child: Consumer<BannerViewModel>(
                      builder: (context, bannerViewModel, child) {
                        if (bannerViewModel.isLoading) {
                          return const CircularProgressIndicator();
                        }
                
                        final banner = bannerViewModel.bannersResponse!.data.banners[0];
                        return GestureDetector(
                          onTap: () {
                            FetchMessagesService().sendMessageId(
                                FetchMessagesRequest(chatId: 4),
                                SharedPreferecesServices.token!);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            child: SizedBox(
                              height: mediaqueryheight(0.15, context),
                              width: double.infinity,
                              child: Image.network(
                                API.baseImageUrl + banner.image,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(AppImages.goFriendsGoLogo);
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ),
            const CustomSizedBoxHeight(0.03),
          ],
        ),
      ),
    );
  }
}

func(BuildContext context) {
  SharedPreferecesServices().getToken();
  context.read<ProfileViewModel>().fetchProfile();
  context.read<StoriesViewModel>().fetchStories();
  context.read<ServiceViewModel>().fetchServices();
  context.read<CarosualViewModel>().fetchCarousals();
  context.read<BannerViewModel>().fetchBanners();
  context.read<BookingViewModel>().fetchBookingsfromservice();
  context.read<ChatListViewmodel>().fetchChatList();
  context.read<TeamsViewModel>().fetchTeams();
  context.read<FixedDeparturesViewModel>().fetchFixedDepartures();
  context.read<SalesPersonViewModel>().fetchSalesPerson();
  context.read<GalleryViewModel>().fetchGallery();
}
