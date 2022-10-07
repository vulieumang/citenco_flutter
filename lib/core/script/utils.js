module.exports = {
    replacetext: _replaceText,
    lineoflib: _lineoflib,
    capitalizefirstletter: _capitalizeFirstLetter,
};

const fs = require('fs')
const replace = require('replace')


function _capitalizeFirstLetter(value) {
    return value.charAt(0).toUpperCase() + value.slice(1);
}

function _lineoflib(arr, item) {
    for (const i in arr) {
        const index = arr[i].indexOf(item);
        if (index !== -1) {
            const first = arr[i][index - 1];
            const last = arr[i][index + item.length];
            if (index === 0 || (first === " " && (last === ":" || last === " "))) {
                return i
            }
        }
    }
    return -1
}


function _replaceText(path, source, destination) {
    return new Promise((resolve, reject) => {
        try {
            if (fs.existsSync(path)) {
                replace({
                    regex: source,
                    replacement: destination,
                    paths: [path],
                    silent: true,
                });
                resolve()
            } else {
                reject(`Not found: ${path}`)
            }
        } catch (e) {
            reject(e)
        }
    })
}