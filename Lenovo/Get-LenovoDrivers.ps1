$Url = "https://download.lenovo.com/catalog/20s7_Win10.xml"

[xml]$x = (New-Object System.Net.WebClient).DownloadString($url)

$DRV = foreach ($p in $x.packages.package) {

    $category = $p.category

    [xml]$driver_xml = (New-Object System.Net.WebClient).DownloadString($p.location)
    
    $version = $driver_xml.Package.version
    $id = $driver_xml.Package.id
    $name = $driver_xml.Package.Title.Desc.'#text'
    $date = $driver_xml.Package.ReleaseDate

    [PSCustomObject]@{
        ID = $id
        Name = $name
        Version = $version
        Category = $category
        Date = $date
    }
}

$DRV | Format-Table -AutoSize