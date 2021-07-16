
import UIKit

final class ViewController: UIViewController {

  @IBOutlet var tableView: UITableView!
  @IBOutlet var undoBarButtonItem: UIBarButtonItem!
  @IBOutlet var trashBarButtonItem: UIBarButtonItem!
  
  private var currentAlbumIndex = 0
  
  private var currentAlbumData: [AlbumData]?
  
  private var allAlbums = [Album]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    allAlbums = libraryAPI.shared.getAlbums()
    
    tableView.dataSource = self
    
    showDataForAlbum(at: currentAlbumIndex)
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  private func showDataForAlbum(at index: Int) {
      
    // defensive code: make sure the requested index is lower than the amount of albums
    if (index < allAlbums.count && index > -1) {
      // fetch the album
      let album = allAlbums[index]
      // save the albums data to present it later in the tableview
      currentAlbumData = album.tableRepresentation
    } else {
      currentAlbumData = nil
    }
    // we have the data we need, let's refresh our tableview
    tableView.reloadData()
  }


}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let albumData = currentAlbumData else {
      return 0
    }
    return albumData.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    if let albumData = currentAlbumData {
      let row = indexPath.row
      cell.textLabel!.text = albumData[row].title
      cell.detailTextLabel!.text = albumData[row].value
    }
    return cell
  }

}

