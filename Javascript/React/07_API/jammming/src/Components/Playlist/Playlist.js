import React from "react";
import { TrackList } from '../TrackList/TrackList';
import './Playlist.css';

export class Playlist extends React.Component {
	render() {
		return (
				<div className="Playlist">
					<input defaultValue={'New Playlist'}/>
					<!-- Add a TrackList component -->
					<TrackList />
					<button class="Playlist-save">SAVE TO SPOTIFY</button>
				</div>
		);
	}
}