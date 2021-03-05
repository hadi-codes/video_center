const sql = require("../services/db");

// constructor
const Video = function (Video) {
  this.vidtitle = Video.vidtitle;
  this.vidmedium = Video.vidmedium;
  this.vidkategorie = Video.vidkategorie;
  this.vidfsk = Video.vidfsk;
  this.vidimg = Video.vidimg;
  this.vidjahr = Video.vidjahr;
};

Video.create = (neuVideo) =>
  new Promise((resolve, reject) => {
    sql.query("INSERT INTO t_video SET ?", neuVideo, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      console.log("created Video: ", { Pvidnr: res.insertId, ...neuVideo });
      resolve({ Pvidnr: res.insertId, ...neuVideo });
    });
  });

Video.findByNr = (videoNr) =>
  new Promise((resolve, reject) => {
    sql.query(`SELECT * FROM t_video WHERE Pvidnr = ${videoNr}`, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      if (res.length) {
        console.log("found Video: ", res[0]);
        resolve(res[0]);
        return;
      }

      // not found Video with the id
      resolve({ kind: "not_found" });
    });
  });

Video.getAll = () =>
  new Promise((reslove, reject) => {
    sql.query("SELECT * FROM t_video", (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      console.log("t_video: ", res);
      reslove(res);
    });
  });

Video.updateByNr = async (Pvidnr, Video) =>
  new Promise(async (reslove, reject) => {
      sql.query(
        "UPDATE t_video SET vidtitle = ?, vidmedium = ?, vidkategorie = ? , vidfsk = ? ,vidjahr = ?  WHERE Pvidnr = ?",
        [
          Video.vidtitle,
          Video.vidmedium,
          Video.vidkategorie,
          Video.vidfsk,
          Video.vidjahr,
          Pvidnr,
        ],
        (err, res) => {
          if (err) {
            console.log("error: ", err);
            reject(err);
            return;
          }

          if (res.affectedRows == 0) {
            // not found Video with the id
            reject({ kind: "not_found" });
            return;
          }

          console.log("updated Video: ", res);
          reslove({ Pvidnr: Pvidnr, ...Video });
        }
      );
  });

Video.remove = (pvidnr) =>
  new Promise((resolve, reject) => {
    sql.query("DELETE FROM t_video WHERE Pvidnr = ?", pvidnr, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Video with the id
        reject({ kind: "not_found" });
        return;
      }

      console.log("deleted Video with id: ", pvidnr);
      resolve(res);
    });
  });

// Ausleihen

Video.leihen = (kundeNr, videoNr) =>
  new Promise((resolve, reject) => {
    sql.query(
      "INSERT INTO t_ausleihen SET ?",
      { Fkunr: kundeNr, Fvidnr: videoNr },
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        console.log("Lend Video: ", res);
        resolve(res);
      }
    );
  });

Video.returnByVideoNr = (videoNr) =>
  new Promise((resolve, reject) => {
    sql.query(
      "DELETE FROM t_ausleihen WHERE Fvidnr = ?",
      videoNr,
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.affectedRows == 0) {
          // not found Video with the id
          resolve({ kind: "not_found" });
          return;
        }

        console.log("returned Video with id: ", videoNr);
        resolve(res);
      }
    );
  });
Video.returnByKundeNr = (kundeNr) =>
  new Promise((resolve, reject) => {
    sql.query(
      "DELETE FROM t_ausleihen WHERE Fkunr = ?",
      kundeNr,
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.affectedRows == 0) {
          // not found Video with the id
          resolve({ kind: "not_found" });
          return;
        }

        console.log("returned Video with id: ", kundeNr);
        resolve(res);
      }
    );
  });

Video.findRentedVideo = (videoNr) =>
  new Promise((resolve, reject) => {
    sql.query(
      `SELECT * FROM t_ausleihen WHERE Fvidnr = ${videoNr}`,
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.length) {
          console.log("found Video: ", res[0]);
          resolve(res[0]);
          return;
        }

        // not found Video with the id
        resolve({ kind: "not_found" });
      }
    );
  });

module.exports = Video;
