/**
 * localStorage 
 * 提供有效期设置
 */
const foowwLocalStorage = {
    /**
     * ttl_ms 为毫秒
     */
    set: function (key, value, ttl_ms) {
        var data = { value: value, expirse: new Date().getTime() + ttl_ms };
        //debugger
        localStorage.setItem(key, JSON.stringify(data));
    },
    get: function (key) {
        var data = JSON.parse(localStorage.getItem(key));
        //debugger
        if (data !== null) {
            if (data.expirse != null && data.expirse < new Date().getTime()) {
                localStorage.removeItem(key);
            } else {
                return data.value;
            }
        }
        return null;
    }
} 
