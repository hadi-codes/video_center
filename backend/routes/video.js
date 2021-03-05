const { ErrorHandler } = require("../helpers/error");
const express = require("express");
const router = express.Router();
const validation = require("../helpers/validation");
const Kunde = require("../models/Kunde");
const Address = require("../models/Address");
const Video = require("../models/Video");

router.post("/create", async (req, res, next) => {
  try {
    // Validat user input
    const { error } = validation.createUpdateVideo(req.body);
    if (error) throw new ErrorHandler(400, error.details[0].message);
    console.log(req.body.Fkunr, req.body.Fvidnr);
    res.send(await Video.create(req.body));
  } catch (error) {
    if (error.statusCode != null) {
      next(error);
    } else {
      console.log(error);
      error = new ErrorHandler(400, error.sqlMessage);
      next(error);
    }
  }
});

router.post("/leihen", async (req, res, next) => {
  try {
    // Validat user input
    const { error } = validation.videoLeihen(req.body);
    if (error) throw new ErrorHandler(400, error.details[0].message);
    console.log(req.body.Fkunr, req.body.Fvidnr);
    res.send(await Video.leihen(req.body.Fkunr, req.body.Fvidnr));
  } catch (error) {
    if (error.statusCode != null) {
      next(error);
    } else {
      console.log(error);
      if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
      else error = new ErrorHandler(400, error.sqlMessage);
      next(error);
    }
  }
});

router.delete("/return", async (req, res, next) => {
  try {
    // Validat user input
    const { error } = validation.videoReturn(req.body);
    if (error) throw new ErrorHandler(400, error.details[0].message);
    let videos = req.body.videos;
    for (var i in videos) await Video.returnByVideoNr(videos[i]);
    res.send({});
  } catch (error) {
    if (error.statusCode != null) {
      next(error);
    } else {
      console.log(error);
      if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
      else error = new ErrorHandler(400, error.sqlMessage);
      next(error);
    }
  }
});

router.get("/all", async (req, res, next) => {
  try {
    res.send(await Video.getAll());
  } catch (error) {
    if (error.statusCode != null) {
      next(error);
    } else {
      console.log(error);
      if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
      else error = new ErrorHandler(400, error.sqlMessage);
      next(error);
    }
  }
});
router.get("/:id", async (req, res, next) => {
  try {
    res.send(await Video.findByNr(req.params.id));
  } catch (error) {
    if (error.statusCode != null) {
      next(error);
    } else {
      console.log(error);
      if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
      else error = new ErrorHandler(400, error.sqlMessage);
      next(error);
    }
  }
});

router.patch("/:id", async (req, res, next) => {
  try {
    //  const { errorID } = validation.pkunr(req.params);
    //  if (errorID) throw new ErrorHandler(400, errorID.details[0].message);
    const { error } = validation.createUpdateVideo(req.body);
    if (error) throw new ErrorHandler(400, error.details[0].message);
    await Video.updateByNr(req.params.id, req.body);

    res.status(200).send({});
  } catch (error) {
    if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
    else error = new ErrorHandler(400, error.sqlMessage ?? error.message);
    next(error);
  }
});


router.delete("/:id", async (req, res, next) => {
  try {
    const pvidnr = req.params.id;
    const force_delete = req.body.force_delete ?? false;
    // if (force_delete) {

    // } else {
    //   res.send(await Video.remove(pvidnr));
    // }

    await Video.returnByVideoNr(pvidnr);

    res.send(await Video.remove(pvidnr));
  } catch (error) {
    if (error.statusCode != null) {
      next(error);
    } else {
      console.log(error);
      if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
      else error = new ErrorHandler(400, error.sqlMessage);
      next(error);
    }
  }
});

module.exports = router;
