
import Foundation
final class miApi {
    
    static let shared = miApi()
    //    func que obtenga los datos de la api()
    func fetchData(onCompletion: @escaping ( [Character]?, APIError?) -> Void) {
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
        
        //        hacer un task (tarea) para guardar datos
        let task = URLSession.shared.dataTask(with: url){
            //            cuando tenga los datos los almacenara en la variable data,el error en variable error y si hay un codigo de respuesta en response
            (data, response, error ) in
            guard let data = data else {
                onCompletion(nil, APIError(message: "Invalid model"))
                return}
            // ejecutara el codigo en esta sección y retornara error si no se puede decodoficar
            guard  let characterList = try? JSONDecoder().decode(CharacterList.self, from: data) else {
                onCompletion(nil, APIError(message: "Invalid request"))
                return
            }// con self indica que es un tipo de objeto, no es algo que estoy creando
            
            onCompletion(characterList.results, nil)
            
            
        }
        task.resume()
    }
}

struct Character: Decodable {
    let identifier: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case status
        case species
        case image
        case gender
    }
}


struct CharacterList: Decodable{
    let results: [Character]
}


struct APIError {
    let message: String
}
