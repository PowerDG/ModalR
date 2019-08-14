export function formatDate (date, fmt) {

    if (/(y+)/.test(fmt)) {
        fmt = fmt.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    let o = {
        'M+': date.getMonth() + 1,
        'd+': date.getDate(),
        'h+': date.getHours(),
        'm+': date.getMinutes(),
        's+': date.getSeconds()
    };
    for (let k in o) {
        if (new RegExp(`(${k})`).test(fmt)) {
            let str = o[k] + '';
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? str : padLeftZero(str));
        }
    }

    return fmt;
};

let dateFilter=(time)=> {
  var date = new Date(time);
  return formatDate(date, 'yyyy-MM-dd hh:mm:ss');
}
export { dateFilter }

function padLeftZero (str) {
    return ('00' + str).substr(str.length);
};


export function isEmpty(value) {
    return(
      value === undefined ||
      value === null ||
      (typeof value === "object" && Object.keys(value).length===0) ||
      (typeof value === "string" && value.trim().length ===0)
    )
}

export function accMulFour(arg1,arg2,arg3,arg4)
{
  var m=0,s1=arg1.toString(),s2=arg2.toString(),s3=arg3.toString(),s4=arg4.toString();
  try{m+=s1.split(".")[1].length}catch(e){}
  try{m+=s2.split(".")[1].length}catch(e){}
  try{m+=s3.split(".")[1].length}catch(e){}
  try{m+=s4.split(".")[1].length}catch(e){}
  return Number(s1.replace(".",""))*Number(s2.replace(".",""))*Number(s3.replace(".",""))*Number(s4.replace(".",""))/Math.pow(10,m)
}
export function accMulTwo(arg1,arg2)
{
  var m=0,s1=arg1.toString(),s2=arg2.toString();
  try{m+=s1.split(".")[1].length}catch(e){}
  try{m+=s2.split(".")[1].length}catch(e){}
  return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
}
