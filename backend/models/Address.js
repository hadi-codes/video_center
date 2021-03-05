const sql = require("../services/db");

// constructor
const Address = function (Address) {
  this.Fkunr = Address.Fkunr;
  this.addstrasse = Address.addstrasse;
  this.addplz = Address.addplz;
  this.addort = Address.addort;
};

Address.create = (newAddress) =>
  new Promise((resolve, reject) => {
    console.log(newAddress);
    sql.query("INSERT INTO t_address SET ?", newAddress, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      console.log("created Address: ", res);
      resolve(newAddress);
    });
  });

Address.findByNr = (kundeNr) =>
  new Promise((resolve, reject) => {
    sql.query(
      `SELECT * FROM t_address WHERE Fkunr = ${kundeNr}`,
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.length) {
          console.log("found Address: ", res[0]);
          resolve(res[0]);
          return;
        }

        // not found Address with the id
        resolve({ kind: "not_found" });
      }
    );
  });

Address.getAll = () =>
  new Promise((resolve, reject) => {
    sql.query("SELECT * FROM t_address", (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      console.log("t_address: ", res);
      resolve(res);
    });
  });

Address.updateByNr = (pkunr, Address) =>
  new Promise((reslove, reject) => {
    sql.query(
      "UPDATE t_address SET addort = ?, addplz = ?, addstrasse = ? WHERE Fkunr = ?",

      [Address.addort, Address.addplz, Address.addstrasse, pkunr],
      (err, res) => {
        if (err) {
          console.log("error: ", err);
          reject(err);
          return;
        }

        if (res.affectedRows == 0) {
          // not found Address with the id
          reject({ kind: "not_found" });
          return;
        }

        console.log("updated Address: ", { pkunr: pkunr, ...Address });
        reslove({ pkunr: pkunr, ...Address });
      }
    );
  });

Address.remove = (Fkunr) =>
  new Promise((resolve, reject) => {
    sql.query("DELETE FROM t_address WHERE Fkunr = ?", Fkunr, (err, res) => {
      if (err) {
        console.log("error: ", err);
        reject(err);
        return;
      }

      if (res.affectedRows == 0) {
        // not found Address with the id
        resolve({ kind: "not_found" });
        return;
      }

      console.log("deleted Address with id: ", Fkunr);
      resolve(res);
    });
  });

module.exports = Address;
