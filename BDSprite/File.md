
start=1&count=10000&symbol=BTC&sort=volume&desc=false
崔轩  21:58:53
五个参数
崔轩  21:59:08
除了之前的start,count之外
崔轩  21:59:58
加上了symbol表示交易种类
崔轩  22:00:17
一共有"AUD", "BRL", "CAD", "CHF", "CLP", "CNY", "CZK",
"DKK", "EUR", "GBP", "HKD", "HUF", "IDR", "ILS",
"INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD",
"PHP", "PKR", "PLN", "RUB", "SEK", "SGD", "THB",
"TRY", "TWD", "ZAR", "BTC", "USD"
崔轩  22:00:22
这个是不变的
崔轩  22:00:48
sort有两个值，一个是volume，根据市值排序，一个是percent根据涨跌幅排序
崔轩  22:01:22
desc两个值，true表示升序，false表示降序
崔轩  22:02:56
额，发错地方了，@可可 ，你看一下就行了


/token/registertoken     //注册token
{
"token" : "","   //64
"pid" : "",       //40
"account" : "",
}

/token/addtag    //增加token
{
    "token" : "","
    "pid" : "",
    "account" : "",
    "tagname" : "",
    "device" : "ios/android"
}

/token/deltag    //删除token
{
"token" : "","
"pid" : "",
"account" : "",
"tagname" : "",
"device" : "ios/android"
}
