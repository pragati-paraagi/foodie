class OnboardingContent {
  String image;
  String title;
  String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnboardingContent> contents = [
  OnboardingContent(
    description: 'From craving to doorstep in just a few taps.',
    image: 'images/3364f8a1d10ab38133fada5b1b356f8b.jpg', // Add appropriate images
    title: 'Easy Ordering, Fast Delivery',
  ),
  OnboardingContent(
    description: 'Real-time updates from kitchen to your doorstep.',
    image: 'images/order.jpg', // Add appropriate images
    title: 'Track Your Order',
  ),
  OnboardingContent(
    description: 'Enjoy special discounts and promotions every day.',
    image: 'images/deals.png', // Add appropriate images
    title: 'Exclusive Deals & Offers',
  ),
  OnboardingContent(
    description: 'Multiple payment options with top-notch security.',
    image: 'images/100b3e69aacb17df3ca06b6cdc4650c6.jpg', // Add appropriate images
    title: 'Secure Payments',
  ),
];