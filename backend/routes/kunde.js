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
    const { error } = validation.createKunde(req.body);
    if (error) throw new ErrorHandler(400, error.details[0].message);
    const kunde = await Kunde.create({
      kuvorname: req.body.kuvorname,
      kunachname: req.body.kunachname,
      kugeburtsdatum: req.body.kugeburtsdatum,
    });
    const address = await Address.create({
      Fkunr: kunde.Pkunr,
      addstrasse: req.body.addstrasse,
      addplz: req.body.addplz,
      addort: req.body.addort,
    });

    res.send({ ...kunde, ...address });
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
    res.send(await Kunde.getAll());
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
    res.send(await Kunde.findByNr(req.params.id));
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

router.delete("/:id", async (req, res, next) => {
  try {
    const kunr = req.params.id;
    const force_delete = req.body.force_delete ?? false;
    console.log(force_delete);
    if (force_delete) {
      await Video.returnByKundeNr(kunr);
      await Address.remove(kunr);
      await Kunde.remove(kunr);
    } else {
      // let videos=Video.
      await Address.remove(kunr);
      await Kunde.remove(kunr);
    }
    res.send();
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
    const { error } = validation.updateKunde(req.body);
    if (error) throw new ErrorHandler(400, error.details[0].message);
    await Kunde.updateByNr(req.params.id, req.body);
    await Address.updateByNr(req.params.id, req.body);

    res.status(200).send({});
  } catch (error) {
    if (error.kind == "not_found") error = new ErrorHandler(404, "not found");
    else error = new ErrorHandler(400, error.sqlMessage ?? error.message);
    next(error);
  }
});

module.exports = router;
