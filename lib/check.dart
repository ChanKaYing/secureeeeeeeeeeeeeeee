/*

@override
Widget build(BuildContext context) {
  if (!isInitialized) {
    return Container();
  }

  return Scaffold(
    appBar: AppBar(
      title: Text('Text Detection App'),
    ),
    body: Column(
      children: [
        CameraPreview(controller),
        SizedBox(height: 16), // Add some space between camera preview and text
        match == true ? Expanded(child: Text(plate, style: TextStyle(fontWeight: FontWeight.bold),)) : Text("no data"),
        Expanded(
          child: ListView.builder(
            itemCount: recognizedTextList.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(recognizedTextList[index]),
              );
            },
          ),
        ),
      ],
    ),
  );
}

 */