// এস কে স্মার্ট নোট অ্যাপ - ব্যাকএন্ড ইঞ্জিন
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('এস কে স্মার্ট নোট অ্যাপ ব্যাকএন্ড চালু হয়েছে!');
});

app.listen(port, () => {
  console.log(`সার্ভার চলছে http://localhost:${port}`);
});

// প্রিমিয়াম মানের ডাটাবেজ কানেকশন ও সিকিউরিটি হ্যান্ডলিং
const mongoose = require('mongoose');

const connectDB = async () => {
  try {
    const conn = await mongoose.connect('mongodb://localhost:27017/sk_smart_note_db', {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log(`এস কে স্মার্ট নোট ডাটাবেজ সফলভাবে যুক্ত হয়েছে: ${conn.connection.host}`);
  } catch (error) {
    console.error(`ডাটাবেজ সংযোগে ত্রুটি: ${error.message}`);
    process.exit(1); // সংযোগ না হলে প্রসেস বন্ধ করে দিবে
  }
};

connectDB();