import 'package:flutter_dotenv/flutter_dotenv.dart';

const String githubUrl = 'https://github.com/Toktarla';
const String defaultImagePath = 'https://t4.ftcdn.net/jpg/01/86/29/31/360_F_186293166_P4yk3uXQBDapbDFlR17ivpM6B1ux0fHG.jpg';
const String recipientEmail = "forstudyonlyacc123@gmail.com";
const String subject = "Feedback";
var pathToFirebaseAdminSdk = dotenv.env['PATH_TO_FIREBASE_ADMIN_SDK'];
var senderId = dotenv.env['SENDER_ID'];

final notificationMessages = [
  "Time to crush your goals, warrior!",
  "Let's grind, champion! Your workout awaits.",
  "Unleash your inner strength! Time to train.",
  "Don't stop now! Your fitness journey continues.",
  "Get ready to sweat and conquer!",
  "Rise and grind, fitness warrior!",
  "Your daily dose of motivation is here. Let's go!",
  "Feel the burn, embrace the challenge!",
  "Push your limits today! Let's do this!",
  "Your best workout is waiting. Are you ready?",
  "No excuses! Time to train like a champion.",
  "Let the gains begin! Time for your workout.",
  "Fuel your body, strengthen your mind. It's workout time!",
  "Every rep counts. Let's make today count!",
  "Transform your body and mind. Time to grind!"
];

final notificationTitles = [
  "Let's Grind, Warrior!",
  "Time to Train!",
  "Workout Time!",
  "Crush Your Goals!",
  "Your Fitness Journey",
  "Rise and Grind!",
  "Motivation Boost!",
  "Embrace the Challenge!",
  "Push Your Limits!",
  "Ready to Workout?",
  "Train Like a Champion!",
  "Let the Gains Begin!",
  "Fuel Your Body!",
  "Every Rep Counts!",
  "Transform Yourself!"
];