const { db } = require("../firebase");

const createAlert = async (req, res) => {
  try {

    const alertData = {
      ...req.body,
      createdAt: new Date(),
    };

    const docRef = await db
      .collection("alerts")
      .add(alertData);

    res.status(201).json({
      success: true,
      id: docRef.id,
      data: alertData,
    });

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

const getAlerts = async (req, res) => {
  try {

    const snapshot = await db
      .collection("alerts")
      .orderBy("createdAt", "desc")
      .get();

    const alerts = [];

    snapshot.forEach((doc) => {
      alerts.push({
        id: doc.id,
        ...doc.data(),
      });
    });

    res.json(alerts);

  } catch (error) {

    res.status(500).json({
      success: false,
      message: error.message,
    });
  }
};

module.exports = {
  createAlert,
  getAlerts,
};