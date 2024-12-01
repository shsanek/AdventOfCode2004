import Foundation

final class DataLoader {
    private static var testData: String? = nil
    private static let session = URLSession(configuration: .default)

    static func test(data: String, block: () -> Void) {
        testData = data
        block()
        testData = nil
    }

    static func load(useCache: Bool = true, file: String = #file) -> String {
        if let testData {
            return testData
        }
        let number = getNumber(fileName: file)
        if let result = loadFromBundle(number: number) {
            return result
        }
        if useCache, let result = loadFromCache(number: number) {
            return result
        }
        return loadFromRemote(number: number, useCache: useCache)!
    }

    private static func getNumber(fileName: String) -> Int {
        let fileName = URL(fileURLWithPath: fileName)
            .lastPathComponent
            .filter { $0.isNumber }
        let numberString = fileName.toArray.removeFirst { $0 == "0" }.joined()
        return Int(numberString)!
    }

    private static func cacheFile(for number: Int) -> URL {
        let tmpName = "\(number).data"
        let fileUrl = FileManager.default.temporaryDirectory.appendingPathComponent(tmpName)
        return fileUrl
    }

    private static func loadFromCache(number: Int) -> String? {
        let fileUrl = cacheFile(for: number)
        if let data = try? Data(contentsOf: fileUrl) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    private static func loadFromRemote(number: Int, useCache: Bool) -> String? {
        let urlString = "https://adventofcode.com/2024/day/\(number)/input"
        let headersData = loadFromBundle(name: "headers")
        let headers = try! JSONDecoder().decode([String: String].self, from: headersData)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        var loadData: Data? = nil
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: request) { data, _, _ in
            loadData = data!
            semaphore.signal()
        }
        task.resume()
        _ = semaphore.wait(timeout: .now() + 5.0)
        let text = String(data: loadData!, encoding: .utf8)
        if useCache {
            try? loadData!.write(to: cacheFile(for: number))
        }
        return text
    }

    private static func loadFromBundle(number: Int) -> String? {
        let numberString = (number < 10 ? "0" : "") + "\(number)"
        let fileUrl = Bundle.module.url(forResource: "day\(numberString)", withExtension: "", subdirectory: "Resources")
        if let fileUrl, let data = try? Data(contentsOf: fileUrl), data.count > 0 {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }

    static func loadFromBundle(name: String) -> Data {
        let bundle = Bundle.module.url(forResource: name, withExtension: "", subdirectory: "Resources")!
        return try! .init(contentsOf: bundle)
    }
}
