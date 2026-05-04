const admin = require("firebase-admin/app");
admin.initializeApp();

const sponsorAsk = require("./sponsor_ask.js");
exports.sponsorAsk = sponsorAsk.sponsorAsk;
