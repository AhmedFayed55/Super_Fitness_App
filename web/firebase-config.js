// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyC0BH0mqHYQhnB1tt5m-YgU4PmLAYn-voY",
  authDomain: "super-fitness-app-9edda.firebaseapp.com",
  projectId: "super-fitness-app-9edda",
  storageBucket: "super-fitness-app-9edda.firebasestorage.app",
  messagingSenderId: "198045329093",
  appId: "1:198045329093:web:aa921865b6a300f35b32ac",
  measurementId: "G-RC0EGP5BQW",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
