//
//  TableController.swift
//  uitableview_load_data_from_json_swift_3
//

import UIKit
import Foundation

class TableController: UITableViewController {

    var TableData:Array< String > = Array < String >()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // get_data_from_url("http://www.kaleidosblog.com/tutorial/tutorial.json")
        // get_data_from_url("https://cssc.cyc.org.tw/api")
        // let request = URLRequest(url: NSURL(string: "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY")! as URL)
        let zhong_shan = getUrlData("https://cssc.cyc.org.tw/api", name: "中山")
        let nan_gang   = getUrlData("https://ngsc.cyc.org.tw/api", name: "南港")
        let xin_yi     = getUrlData("https://xysc.cyc.org.tw/api", name: "信義")
        let da_an      = getUrlData("https://dasc.cyc.org.tw/api", name: "大安")
        let wen_shan   = getUrlData("https://wssc.cyc.org.tw/api", name: "文山")
        let nei_hu     = getUrlData("https://nhsc.cyc.org.tw/api", name: "內湖")
        
        let lu_zhou    = getUrlData("https://lzcsc.cyc.org.tw/api", name: "蘆洲")
        let tu_cheng   = getUrlData("https://tccsc.cyc.org.tw/api", name: "土城")
        let xi_zhi     = getUrlData("https://xzcsc.cyc.org.tw/api", name: "汐止")
        let yong_he    = getUrlData("https://yhcsc.cyc.org.tw/api", name: "永和")
        
        TableData.append(zhong_shan)
        TableData.append(nan_gang)
        TableData.append(xin_yi)
        TableData.append(da_an)
        TableData.append(wen_shan)
        TableData.append(nei_hu)
        
        TableData.append(lu_zhou)
        TableData.append(tu_cheng)
        TableData.append(xi_zhi)
        TableData.append(yong_he)
        

    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableData.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = TableData[indexPath.row]
        
        return cell
    }
  

    func getUrlData(_ link:String, name:String) -> String
    {
        let request = URLRequest(url: NSURL(string: link)! as URL)
        do {
            // Perform the request
            let response: AutoreleasingUnsafeMutablePointer<URLResponse?>? = nil
            
            // Convert the data to JSON
            do{
                let data = try NSURLConnection.sendSynchronousRequest(request, returning: response)
                let jsonSerialized = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                if let json = jsonSerialized, let gym = json["gym"], let swim = json["swim"] {
                    
                    let gym_arr = gym as! NSArray
                    let swim_arr = swim as! NSArray
                    
                    let gym_on = gym_arr[0] as! String
                    let gym_all = gym_arr[1] as! String
                    
                    let swim_on = swim_arr[0] as! String
                    let swim_all = swim_arr[1] as! String
                    
                    let result = name + " || 健身：" + gym_on + "/" + gym_all + " | " + "游泳 ：" + swim_on + "/" + swim_all
                    
                    // TableData.append("中山 || 健身房：" + gym_on + "/" + gym_all + " " + "游泳池：" + swim_on + "/" + swim_all)
                    return result
                    // TableData.append(gym as! String)
                    // print(gym)
                    // print(explanation)
                }
            }
            catch
            {
                return ""
            }
        }
        return ""
    }
    
    
    
    func get_data_from_url(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        // request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
               return
            }
            self.extract_json(data!)
        })
        task.resume()
    }

    
    func extract_json(_ data: Data)
    {
        let json: Any?
        
        do
        {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch
        {
            return
        }
        
        guard let data_list = json as? NSArray else
        {
            return
        }
        
        
        if let countries_list = json as? NSArray
        {
            for i in 0 ..< data_list.count
            {
                if let country_obj = countries_list[i] as? NSDictionary
                {
                    TableData.append(country_obj["country"] as! String)
                    /*
                    // if let country_name = country_obj["country"] as? String
                    if let country_name = country_obj["gym"] as? String
                    {
                        // if let country_code = country_obj["code"] as? String
                        if let country_code = country_obj["swim"] as? String
                        {
                            TableData.append(country_name + " [" + country_code + "]")
                        }
                    }
                     */
                }
            }
        }
        
        
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})

    }

    func do_table_refresh()
    {
        self.tableView.reloadData()
        
    }
    

}
