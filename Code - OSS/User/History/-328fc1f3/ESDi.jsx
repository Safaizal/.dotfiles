
function MovieCard({movie}) {
  function onFavouriteClick(){
    alert("clicked on");
  }
  return (
    <div className="movie-card" >
     <div className="movie-poster" >
      <img src={movie.url} alt={movie.title}>
      <div className="movie-overlay">
        <button className="Favourite-btn" onClick={onFavouriteClick}>
          >vv<
        </button>
      </div>
      <div className="movie-info">
        <h3>
          {movie.title}
        </h3>
        <p>
          {movie.release}
        </p>
      </div>
     </div> 
    </div>
  )
}
