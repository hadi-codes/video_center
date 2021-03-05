const Joi = require("@hapi/joi");

const pkunr = (data) => {
  const schema = Joi.object({
    id: Joi.number().integer().greater(999).less(10000).required(),
  });
  return schema.validate(data);
};
const createKunde = (data) => {
  const schema = Joi.object({
    kuvorname: Joi.string().trim().alphanum().min(2).max(50).required(),
    kunachname: Joi.string().trim().alphanum().min(2).max(50).required(),
    kugeburtsdatum: Joi.date().iso().min("1-1-1974").required(),
    addstrasse: Joi.string().trim().min(3).max(50).required(),
    addplz: Joi.string()
      .trim()
      .regex(/^[0-9]{5}$/)
      .required(),
    addort: Joi.string().trim().alphanum().min(2).max(30).required(),
  });
  return schema.validate(data);
};
const updateKunde = (data) => {
  const schema = Joi.object({
    kuvorname: Joi.string().trim().alphanum().min(2).max(50).required(),
    kunachname: Joi.string().trim().alphanum().min(2).max(50).required(),
    kugeburtsdatum: Joi.date().iso().min("1-1-1974").required(),
    addstrasse: Joi.string().trim().min(3).max(50).required(),
    addplz: Joi.string()
      .trim()
      .regex(/^[0-9]{5}$/)
      .required().required(),
    addort: Joi.string().trim().alphanum().min(2).max(30).required(),
  }).min(1).required();
  return schema.validate(data);
};
const createUpdateVideo = (data) => {
  const schema = Joi.object({
    vidtitle: Joi.string().min(2).max(50).required(),
    vidmedium: Joi.string().min(2).max(50).required(),
    vidkategorie: Joi.string().trim().alphanum().min(2).max(50).required(),
    vidfsk: Joi.string().trim().valid("0", "6", "12", "16", "18").required(),
    //vidimg: Joi.string().trim().min(3).max(50),
    vidjahr: Joi.number().integer().min(1800).required(),
  });
  return schema.validate(data);
};
const videoLeihen = (data) => {
  const schema = Joi.object({
    Fkunr: Joi.number().integer().greater(999).less(10000).required(),
    Fvidnr: Joi.number().integer().greater(9999).less(100000).required(),
  });
  return schema.validate(data);
};

const videoReturn = (data) => {
  const schema = Joi.object({
    videos: Joi.array()
      .min(1)
      .items(Joi.number().integer().greater(9999).less(100000))
      .required(),
  });
  return schema.validate(data);
};

module.exports.createKunde = createKunde;
module.exports.videoLeihen = videoLeihen;
module.exports.videoReturn = videoReturn;
module.exports.createUpdateVideo = createUpdateVideo;
module.exports.updateKunde = updateKunde;

module.exports.pkunr = pkunr;
