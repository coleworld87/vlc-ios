/*****************************************************************************
 * VideoModel.swift
 *
 * Copyright © 2018 VLC authors and VideoLAN
 * Copyright © 2018 Videolabs
 *
 * Authors: Soomin Lee <bubu@mikan.io>
 *
 * Refer to the COPYING file of the official project for license.
 *****************************************************************************/

class VideoModel: MediaLibraryBaseModel {
    typealias MLType = VLCMLMedia

    var files = [VLCMLMedia]()

    var indicatorName: String = NSLocalizedString("MOVIES", comment: "")

    var notificaitonName: Notification.Name = .VLCVideosDidChangeNotification

    required init(medialibrary: VLCMediaLibraryManager) {
        medialibrary.addObserver(self)
    }

    func isIncluded(_ item: VLCMLMedia) {
    }

    func append(_ item: VLCMLMedia) {
        files.append(item)
    }
}

extension VideoModel: MediaLibraryObserver {
    func medialibrary(_ medialibrary: VLCMediaLibraryManager, didAddVideo video: [VLCMLMedia]) {
        video.forEach({ append($0) })
        NotificationCenter.default.post(name: notificaitonName, object: nil)
    }
}