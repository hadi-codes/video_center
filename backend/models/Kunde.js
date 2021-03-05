const sql = require("../services/db");

// constructor
const Kunde = function (Kunde) {
  this.kuvorname = Kunde.kuvorname;
  this.kunachname = Kunde.kunachname;
  this.kugeburtsdatum = Kunde.kugeburtsdatum;
};

Kunde.create = (neuKunde) =>
  new Promise((resolve, reject) => {
    sql.query("INSERT INTO T_Kunde SET ?", neuKunde, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      console.log("created Kunde: ", { Pkunr: res.insertId, ...neuKunde });
      resolve({ Pkunr: res.insertId, ...neuKunde });
    });
  });

Kunde.findByNr = (kundeNr) =>
  new Promise((resolve, reject) => {
    sql.query(
      `SELECT Pkunr, kuvorname, kunachname, kugeburtsdatum, addstrasse, addplz, addort, T_Ausleihen.Fvidnr AS video FROM T_Kunde LEFT JOIN T_Ausleihen ON Pkunr = fkunr LEFT JOIN T_Address ON T_Kunde.Pkunr = T_Address.Fkunr WHERE Pkunr = ${kundeNr}`,
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.length) {
          console.log("found Kunde: ", res[0]);
          resolve(res[0]);
          return;
        }

        // not found Kunde with the id
        reject({ kind: "not_found" });
      }
    );
  });

Kunde.getAll = () =>
  new Promise((reslove, reject) => {
    sql.query(
      "SELECT Pkunr, kuvorname, kunachname, kugeburtsdatum, addstrasse, addplz, addort, T_Ausleihen.Fvidnr AS video FROM `T_Kunde` LEFT JOIN T_Ausleihen ON Pkunr = fkunr LEFT JOIN T_Address ON T_Kunde.Pkunr = T_Address.Fkunr ORDER BY `T_Kunde`.`Pkunr` ASC      ",
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }
        console.log("T_Kunde: ", res);

        let kunden = [];
        let lastEntrie = { Pkunr: null };

        for (var i in res) {
          let kunde = res[i];
          let videos = kunde.video == null ? null : [kunde.video];
          delete kunde.video;
          kunde["videos"] = videos;
          if (lastEntrie.Pkunr == kunde.Pkunr) {
            kunden[kunden.length - 1].videos.push(videos[0]);
          } else {
            lastEntrie = kunde;
            kunden.push(lastEntrie);
          }
        }

        reslove(kunden);
      }
    );
  });

Kunde.updateByNr = async (pkunr, Kunde) =>
  new Promise(async (reslove, reject) => {
    // let keys = Object.keys(Kunde);
    // let fields = "";
    // let valus = [];
    // for (var key in keys) {
    //   fields = fields + " " + keys[key] + " = ?";
    //   if (keys[key] != keys[keys.length - 1]) fields = fields + " ,";
    //   valus.push(Kunde[keys[key]]);
    // }
    // valus.push(pkunr);
    sql.query(
      "UPDATE T_Kunde SET kuvorname = ?, kunachname = ?, kugeburtsdatum = ? WHERE pkunr = ?",
      [Kunde.kuvorname, Kunde.kunachname, Kunde.kugeburtsdatum, pkunr],
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.affectedRows == 0) {
          // not found Kunde with the id
          reject({ kind: "not_found" });
          return;
        }

        console.log("updated Kunde: ", res);
        reslove({ pkunr: pkunr, ...Kunde });
      }
    );
  });

Kunde.remove = (pkunr) =>
  new Promise((resolve, reject) => {
    sql.query("DELETE FROM T_Kunde WHERE pkunr = ?", pkunr, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Kunde with the id
        resolve({ kind: "not_found" });
        return;
      }

      console.log("deleted Kunde with id: ", pkunr);
      resolve(res);
    });
  });

module.exports = Kunde;
